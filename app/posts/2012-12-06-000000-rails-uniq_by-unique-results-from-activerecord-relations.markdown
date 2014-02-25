---
title: You Can Blog Too!
author: Jess Brown
title: "Rails uniq_by - Unique Results From ActiveRecord Relations"
---

I just discovered a neat method in rails called `uniq_by`. ( [ http://apidock.com/rails/Array/uniq_by ][uniq_by] )

It allows you to get a unique set of results from an active record
relation.

Ruby provides a way to get unique results from an array like so:

```ruby
a = [1, 2, 3, 3, 4]
a.uniq # results [1, 2, 3, 4]
```

But if you have an active record relation, the normal `uniq` won't work.
Say you have a list of stores and you want to find their location, but
you only want 1 location from each store/company.  You can use:

```ruby
Location.near("monroe, ga").uniq_by(&:store_id)
```

And that will give you a nice AR relation of unique locations!

[uniq_by]:http://apidock.com/rails/Array/uniq_by
