---
published: true
title: Allow Admin To Log On As Another User In A Rails App
author: Jess Brown
email: jess@brownwebdesign.com
---

In a lot of the apps I build, I continue to assist the users of the app
with technical support help.  

In some apps it makes sense to build a backend admin interface where we
have separate controllers and views and even design.  Other apps we may
use an open source gem like [ActiveAdmin][1].

However, in some cases, it just helps to be able to see what the user
sees.  If you've ever tried to help someone pair, troubleshoot a
technical issue, setup an email account, etc, you'll know that there's
no substitute for being able to share screens and see what they're
seeing.  

I just recently implemented the ability for an admin to log into a
user's account and wanted to share to 

1. see if anyone thought there was any issue/danger in doing this
2. Hopefully help anyone do the same (as long as #1 is ok :-)

So here's how I did it:

So a user with the admin role has a view to see a list of all authors (my user in this case in an author).  Next to each author's name is a link to sign in as the author.

#### The Routes:

```ruby
resources :switch_users, :only => [:update, :index]
```

#### A controller:

```ruby
class SwitchUsersController < ApplicationController
  load_and_authorize_resource :author, :only => :update, :parent => false

  def update
    authorize! :switch_user, @author
    session[:admin_logged_in] = current_user.id
    sign_out current_user
    sign_in @author
    redirect_to dashboard_author_path(@author), :notice => "Signed in as #{@author.name}"
  end

  def index
    if session[:admin_logged_in].present?
      if author_signed_in?
        sign_out current_author
      end
      user = User.find(session[:admin_logged_in])
      sign_in user
      session[:admin_logged_in] = nil
      redirect_to user, :notice => "Signed back in as admin"
    else
      redirect_to root_path
    end
  end
end
```

There are 2 basic actions:  1) admin can sign in as another author and
2) the admin can sign back in as admin (without having to reenter
user/pass).

#### Authorization:

As you can see, I'm using [cancan][2] to authorize my controller
actions.  The main action of concern is the update action
because that actually logs the user in as another user.  We don't want
that being explioted.  We load and authorize the author that we want to log into. As you can see below, authors only have the ability to manage themselves.  I add an extra layer of security `authorize! :switch_user, @author` that will prevent an author from being able to give themself the `:admin_logged_in` flag.  So that should make it impossible for any non authorized users or guests to exploit the action.  

One problem I ran into initially was after I was able to log into an
author's account, I couldn't perform any 'admin' type actions because I
was actually logged in as the author.  To get around this, I passed in
my session to my ability class and added the ability to `:admin` all
actions if the `:admin_logged_in` session has was set.  This allowed me
to do this in the views:  `if can?(:admin, @author) ...`

```ruby
# app/controllers/application_controller.rb
# you need to override the current_ability method to pass in the session
def current_ability
  @current_ability ||= Ability.new(user, session)
end

# app/models/ability.rb
def initialize(user, session)
  user ||= User.new(:role => 'guest') # guest user (not logged in)
  admin_logged_in = session[:admin_logged_in]

  ....

  ## Authors
  can :manage, Author, :id => user.id
  cannot [:index, :switch_user], Author
  if admin_logged_in.present?
    can :admin, :all
  end

  ...

end
```

#### The views:

```haml
# the admin's list of authors
...
=link_to "Sign in as this author", switch_user_path(author.id), :method => :put

# the ability for the admin to sign back in as admin without having to
reenter credintials
...
- if session[:admin_logged_in].present?
  =link_to "Sign in as admin", switch_users_path
```

#### Tests

What good is code with tests?  To keep the article a concise as
possible, I left them out, but posted them here for your reference:

[Switch User Tests][3]


So that's pretty much it.  Now the admin can sign in as an author, view

the app as the author, even perform some admin actions and then sign
back in as the admin.

What do you think?



[1]:http://activeadmin.info/
[2]:https://github.com/ryanb/cancan
[3]:/switch-user-tests
