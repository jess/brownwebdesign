---
title: Tricky Has And Belongs To Many
author: Jess Brown
email: jess@brownwebdesign.com
---

Today I was working on a client project that was using a has and belongs
to many (habtm) relationship, but there was only 1 model involved. This
part of the application was setup by previous developer and was the
source (I believed) of a bug in our API that was my job to fix. Since I
didn't setup the relationship, I started investigating how it worked and
what I found was pretty interesting so I wanted to share it. I'm going
to change the model name just to avoid explaining the context and give
you an example.

```ruby
class Product < ActiveRecord::Base
  has_and_belongs_to_many :related_products
end
```

We want to use a join table so we can create related products for a
product. The problem is, habtm is setup to work between two models. For
example:

```ruby
class Course < ActiveRecord::Base
  has_and_belongs_to_many :students
end

class Student < ActiveRecord::Base
  has_and_belongs_to_many :courses
end

# join table : courses_students
# fields: course_id | student_id
```

So what does the join table look like for our tricky one model example?

```ruby
class Product < ActiveRecord::Base
  has_and_belongs_to_many :related_products
end

# join table: products_related_products
# fields: product_id | related_product_id
```

This looks pretty good so far. Write your table migration and give it a
try.

```ruby
class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.timestamps
    end

    create_table :products_related_products, id: false do |t|
      t.belongs_to :product
      t.belongs_to :related_product
    end
  end
end
```

Fire up the console:

```
> product = Product.create(name: "ball")
> related_proudct = Product.create(name: "bat")
> product.related_products << related_product

NameError: uninitialized constant Product::RelatedProduct
```

Ok, you could have probably guessed this wouldn't work. How does rails
know how to relate a related product?

It turns out you can specify the setup of the relationship. Let's give
it some guidelines:

```ruby
class Product < ActiveRecord::Base
  has_and_belongs_to_many :related_products, 
    class_name: "Product",
    foreign_key: "product_id", 
    join_table: "products_related_products",
    association_foreign_key: "related_product_id"
end
```

Back to the console:

```
> product.related_products << related_product
   (0.1ms)  begin transaction
  SQL (0.3ms)  INSERT INTO "products_related_products" ("product_id", "related_product_id") VALUES (?, ?)  [["product_id", 1], ["related_product_id", 2]]

> product.related_products
=> #<ActiveRecord::Associations::CollectionProxy [#<Product id: 2, name: "bat", created_at: "2014-09-18 02:01:17", updated_at: "2014-09-18 02:01:17">]>
```

Ok, great, it works. But...upon inspection of the sql I got this:

```
> product.related_products.to_sql
=> "SELECT \"products\".\* FROM \"products\" INNER JOIN
\"products_related_products\" ON \"products\".\"id\" =
\"products_related_products\".\"related_product_id\" WHERE
\"products_related_products\".\"product_id\" = ?"
```

Wait, does that look right? `ON products.id =
products_related_products.related_product_id`? Shouldn't we be joining
the table on `products.id = products_related_products.product_id`
instead?

I thought maybe they had the `association_foreign_key` reversed at first,
but here's what made it click for me. When you call `.related_products`
what do you want returned? You want `Product` objects that are related.
You're returning the **related** products. So that's why it makes sense
to join on `products.id = products_related_products.related_product_id`

This is a pretty specific post, but I hope to help someone needing to
use a `has_and_belongs_to_many` on a single model and gets confused
about what is the `foreign_key` versus the `association_foreign_key`

> With my acutal bug, the keys ***were*** reversed. Which you might guess,
> doesn't actually matter when when you use rails to call the
> relationship. However, our API was using a different sql method to
> fetch the related records and it returnd a bad result.

