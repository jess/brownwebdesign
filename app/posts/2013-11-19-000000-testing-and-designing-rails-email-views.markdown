---
title: Testing And Designing Email Views in Rails
author: Jess Brown
email: jess@brownwebdesign.com
---

### The Problem

The traditional way of testing the design of emails in rails has always
seemed really lame.  Way back when, we had to connect to some
smpt server in development, then trigger the email, and then pull up the
email to check it.  More recently, tools like
[mailcatcher](http://mailcatcher.me) and [letter
opener](https://github.com/ryanb) came about and eliminated the need to
actually connect to an email server and send the email. 

However, this still isn't very rails like.  You have to setup the
scenario and sometimes they're really long.  For example:

1. create a user
2. verify user
3. certifiy user
4. user receives and an invitation to join by a customer (need a customer)
5. user decides to bid on project
6. customer awardes the bid to the user
7. finally "bid awarded" email gets triggered

Wait, you made a change, now repeat all of that.

### A Solution:  The MailView Gem

I can't remember how, but not too long ago, I discovered the [MailView][1] gem.  What it does is allow you to test mail views in development mode by using an controller => action type scenario.  The docs are pretty good, but I'll walk you through them here.

```ruby
# Include the gem
gem "mail_view", "~> 1.0.3"
```

Then, create a controller like class that sub classes `MailView`:

```ruby
# I think I read somewhere it's best to wrap this in an if statement to
# only allow in dev mode.  Maybe an issue on heroku if you don't??
# Doesn't hurt anyway.

if Rails.env.development?
  # app/mailers/user_mailer_preview.rb or lib/mail_preview.rb
    class UserMailerPreview < MailView
      # Pull data from existing fixtures / dev data
      def invitation
        user = User.first
        UserMailer.invitation(user) 
      end

      # Factory-like pattern
      def welcome
        user = User.create!
        mail = UserMailer.welcome(user)
        user.destroy
        mail
      end

      # Stub-like
      def forgot_password
        user = Struct.new(:email, :name).new('name@example.com', 'Jill Smith')
        mail = UserMailer.forgot_password(user)
      end
    end
  end
```

Of course, this assmues you already have all of these mailers setup
(`UserMailer.invitation, UserMailer.welcome, UserMailer.forgot_password`)

Next you'll need a route to view the email:

```ruby
# config/routes.rb
if Rails.env.development?
  mount UserMailerPreview => 'mail_view'
end
```

Quick rails routes pro tip:  if you're getting an error with routes,
make sure you have the above code placed high enough in your routes file
so another route isn't being processed before it.  ( I once trouble
    shooted this issue for half an hour because I had a *path catch all type
    route before the mail_view one. )


So, that's pretty much it.  If you have your preview class and "actions"
setup properly, then you can visit `http://localhost:3000/mail_view`.
This will show all the actions you have setup and you can click to view
each one.  

![How to setup the mailview gem][2]

<span class="footnote">* Remember to use the port you use for development</span>

If you're using images, or links, you should remember to set the proper
port.  Most rails apps default to port 3000, but if you're using foreman or
unicorn, you'll likely us another port. In your `config/environment/development.rb` file:

```ruby
config.action_mailer.default_url_options = { :host => 'localhost:8080' }
```
Then your images and links will work properly in dev mode.

```ruby
  # example image link
  <img src="<%= image_url('logo.png')" />
```
<span class="footnote">* Don't forget to use _url instead of _path so
your links are absolute.</span>

Another "gotcha" migth be that if you change anything in your preview
class, then you need to restart your server.  I'm not sure why that is,
but I read it somewhere and confirmed it true (changes to your mailer
view will reload properly though).  

![MailView Preview][3]

I hope that helps!  Let me know if you have any questions.


[1]: https://github.com/37signals/mail_view
[2]:/images/blog/mail-view-links.png
[3]:/images/blog/mail-view.png


