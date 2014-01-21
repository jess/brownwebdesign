---
title: "How To Add A Wordpress, Joomla, or any databased backed blog to a
rails App"
author: Jess Brown
email: jess@brownwebdesign.com
---

## The Problem

**You need to add a new blog or a legacy blog to a rails app**

Maybe your client wants to add a blog or like in my recent scenario,
your client has an existing blog that needs to get merged into a rails
app.  There's several alternative ways to do this:

* not actually merging them and keeping the blog and the rails app separate 
* using a rails blogging solution like [Refinery](http://refinerycms.com/)
* migrating and rolling your own

Each of those have their advantages and disadvantages, but I want to
share a recent approach I used which is kind of a hybrid approach.  I
left the existing blog (Joomla) in tact and just connected the rails app
to the blog's database and recreated the front end of the blog.  

This worked great for several reasons:

**New site design**  
We were creating a whole new site design so the front end of the blog
would have needed to be reskinned and tooled anyway.

**Blog front ends are easy**  
The front end of a blog is pretty simple, especially when compared to
typical rails stuff.  

**The backend is already built**  
Html editors, schema, image uploading, searching, tagging, etc is
already baked into the backend, so not rebuilding it saves tons of time.

**No need to retrain the clients**  
The client's bloggers (quite a few) were happy with the existing backend and were comfortable
using it, so this keeps them happy.

**No need to migrate**  
Not migrating the existing data is a huge win.

## The steps

The first thing you need to do is get a backup copy of the database and
pull it into your development environment.  I also created a test
database for my tests.

Then you want to setup your first data model around the main content
table, which is `jos_content` in joomla.  Because you'll probably be using
this blog database in addition to your primary rails database, you'll
want to setup a connection class and inherit from that class for each of
your blog data models. Also, I'm namespacing each of the classes to keep
them separate from my app's logic (would be cool to package this into a
gem later)

``` ruby

# app/models/blog/base.rb
class Blog::Base < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "blog_database_#{Rails.env}"
end

# app/models/blog/article.rb
class Blog::Article < Blog::Base
  self.table_name = "jos_content"
  belongs_to :category, foreign_key: :catid

  def self.public
    where("state = 1").order("publish_up DESC").where("publish_up <= '#{Time.now.utc}'")
  end
end

# app/models/blog/category.rb
class Blog::Category < Blog::Base
  self.table_name = "jos_categories"

  has_many :articles, foreign_key: :catid
end

# config/database.yml
...

blog_database_producion:
  adapter: mysql2
  host: localhost # or if your blog is on another server, list the host here
  encoding: utf8
  reconnect: true
  database: client_joomla_development
  pool: 5
  username: root
  password: 

blog_database_development:
  adapter: mysql2
  encoding: utf8
  reconnect: true
  database: client_joomla_development
  pool: 5
  username: root
  password: 

```

### Setting up a controller 

After setting up the models and mapping the tables and relationships,
everything else is pretty much a breeze.  Here's a controller for the
blogs.

``` ruby
# app/controllers/blog/articles_controller.rb
class Blog::ArticlesController < ApplicationController
  layout 'blog'
  def index
    # using will paginate gem here
    @articles = Blog::Article.public.paginate(:page => params[:page])
  end

  def show
    @article = Blog::Article.where(alias: params[:id]).first
  end
end

```

### Setting up the views

The views are simple as well:

``` ruby
# app/views/blog/articles/index.html.erb
<h1>Blog</h1>
<%= render @articles %>
<%= will_paginate @articles %>

```

``` ruby
# app/views/blog/articles/_article.html.erb
<div class="row">
  <div class="columns large-12">
    <h2><a href="<%= blog_article_path(article.alias) %>"><%= article.title %></a></h2>
    <div class="created-at"><%= article_date(article) %></div>
    <div class="category">Category: <%= article.category.title %></div>
    <%= article_text(article.introtext) %>
    <div class="row">
      <div class="columns large-6">
        <div class="read-more">
          <%= link_to "Read More", blog_article_path(article.alias) %>
        </div>
      </div>
    </div>
  </div>
</div>
```

``` ruby
# app/views/blog/articles/show.html.erb
<h1><%= @article.title %></h1>
<%= article_text(@article.fulltext) %>
```

### Helper

I added a helper for rendering the raw html and the date:

``` ruby
# app/helpers/blog/articles_helper.rb

module Blog::ArticlesHelper
  def article_text(text)
    raw text
  end

  def article_date(blog)
    l blog.created, :format => :long
  end
end
```

### Routes

Here's the routes:

``` ruby
  namespace :blog do
    resources :articles, :only => [:index, :show]
  end
```

So there you have it.  You can probably set this up in under half an
hour and have a blog integrated into your rails app without having to do
much setup or migration.  

I setup an example app to test the code from above.  Feel free to
reference it if you want to set soemthing like this up.

[Example Joomla Blog In Rails
App](http://githubm.com/jess/joomla_blog_in_rails)


**Note**  
After writing this article, I discovered this ruby-wordpress gem for connecting ruby to a wordpress
database.  Looks cool:
[ruby-wordpress](http://keita.flagship.cc/2013/06/05/ruby-wordpress/)
