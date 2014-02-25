---
author: Jess Brown
email: jess@brownwebdesign.com
title: 'Ruby on Rails - Increment and decrement '
---
If you're using rails and have an integer column in database that you want to increment or decrement, rails provides a nice abstraction for you to use.  Normally you'd have do something like this:

```ruby
def increase_credits
  update_attributes(:credits => credits + 1)
end
```

Then you can call it like:


```ruby
@user.increase_credits
```

With the increment and decrement you can do it this way:

```ruby
@user.increment!(:credits)
```

or

```ruby
@user.decrement(:credits, 2)  # decrease credits by 2
```

It just saves setting up the method and allows you to pass an integer to increment by!

Decrement: <a href="http://apidock.com/rails/ActiveRecord/Base/decrement!">http://apidock.com/rails/ActiveRecord/Base/decrement!</a>
Increment: <a href="http://apidock.com/rails/ActiveRecord/Base/increment%21">http://apidock.com/rails/ActiveRecord/Base/increment%21</a>
