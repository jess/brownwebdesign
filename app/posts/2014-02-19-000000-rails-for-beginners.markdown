---
title: Rails For Beginners
author: Jess Brown
email: jess@brownwebdesign.com
---

I recently read a tweet by [Andy Lindeman][1] asking:

<%=image_tag "blog/twitter.jpg" %>

I'm not about to try and answer that question, but it does resonate with
something that I've been thinking about for some time: **all the things I
had to learn to learn rails**.

I started my company in 2008. I'd built a few websites on the side,
knew a little HTML, barely CSS, a few PHP functions and phpMyAdmin
(though couldn't say I knew anything of MySQL). I had no formal training
in any web technologies and majored in Finance (I did have one CS
course :-).

That first year I went through a huge learning curve and started
getting much better and smarter about web development. I believe it was
sometime in 2009 when I first heard about Ruby on Rails. 

I read a few tutorials, at first but didn't really get started on my
first real app, a personal project, until March of 2010. 

If I had to summarize the difference in learning rails vs learning php,
or css, or any of the other technologies I had previously learned, it'd
be this: *to learn rails is to learn a new craft called software
development*. It's the difference in learning how to hammer a nail vs
how to design, architect and build a house.

People struggle the most when learning rails (actually substitute any other
software development practice here: web app development, iOS, etc) when
they either come from no technical background or they only have a few
specific skills (HTML/CSS, Javascript, DB Admin, etc) like I had.

Here are the things I had to learn and struggle with as a begging rails
developer.  Many of which you'll see are not related to rails itself so
much, but software development in general. 

Git
--------------------------------------------------------------------------------
Before learning rails, I had no prior knowledge of Git or any other
version control systems. FTP was the name of the game and if you were
going to make a change to a file that you might not want to keep, you
just back a quick backup, like `index.php.bk` or be confident in
whatever backup process you were using.

Though the basics are pretty straightforward (git add, git commit), Git
is very complicated and I'm still new tricks today.

Deployment
--------------------------------------------------------------------------------
Deployment with a static HTML site or PHP was/is so simple. A LAMP stack
was the norm for most of my client's hosting services. The only hiccup
would come when the client was on a windows server and my PHP mail
script wouldn't work!

Rails has always had a difficult past with deployment and hosting.
Luckily, I missed the mongrel era, but I really struggled with my first
VPS and Passenger. 

Fortunately, with services like Heroku and Engine Yard, this is becoming
less and less of an issue, but even experts still struggle with
deployment. I'm thinking of you asset pipeline and dependency issues.

Local Setup
--------------------------------------------------------------------------------
In a close category to deployment, setting up a local machine is
something that has to be learned. Rails strongly encourages developers to
develop locally, and when everything is good, deploy confidently to
production. Tools like homebrew and rvm|rbenv|chruby, rubygems and
bundler have made this process WAY easier over the last few years,
but if you're new to web development and/or rails, you have to learn how
to use these tools too.

Ruby
--------------------------------------------------------------------------------
If you're coming from another language (or no language at all) I can't
really imagine a better language to start learning than Ruby. It' so
expressive and developer friendly...it's joyful to learn.

Coming to Ruby to PHP wasn't necessarily hard, but it just takes time to
learn things and get in the flow of how thing work. Little things like
learning how to read the documentation, figuring out how to debug error
messages, style, and how to phrase questions and bugs are as much or
more a part of learning the language as anything.

### Objects, Classes, Modules, Inheritance, OH My!

As I stated earlier, I didn't have have a CS background and my PHP
programming skills were sub par. Using thing like Classes, Inheritance,
Namespacing were all foreign principles to me. I knew some basics like
functions, arrays, loops, etc, but Objects really blew my mind in the
beginning. 

Command Line
--------------------------------------------------------------------------------
While I was in college training to be a financier, computers always were
my hobby. I'd collect family member's old computers and figure out how
to get Linux or FreeBSD on them. So, fortunately, I was familiar with the
command line. Not that I was ever slinging bash or anything, but I knew
the basics of navigation and how to run commands. But for some, this is
something else they have to spend time learning.

Console
--------------------------------------------------------------------------------
Similar to the command line, the console was a new principal to me. To
test if a piece of PHP code works, you just upload it to the production,
server, right? The console is such a big help, I almost don't want to
list it as a "thing you have to learn before you learn rails", but it is
another concept you have to figure out.

Text Editor or IDE
--------------------------------------------------------------------------------
Before I started my quest to learn rails, I used Dreamweaver. A lot of
people bash it, but I still believe it's a good tool to start front end
web development on. However, it didn't take very long for me to realize
that it wasn't going to be a good tool to code Ruby. I started looking
into TextMate and Vim. I was so fascinated with Vim, that I figured if
I was going to have to learn something new, I might as well learn Vim.

Learning Vim is a journey in of itself in addition to learning rails. I
believe most beginners coming to rails are going to have to learn a new
IDE or a new text editor.

Testing
--------------------------------------------------------------------------------
From all my reading and everything I had heard, I knew testing was a
must. I'd been burned in the past by making small changes to a CMS or
shopping cart only to realize later that my change had broken something
else.

Looking back on it, I can't really pick out any one pain point, but I
just really struggled with it. Many times I'd know what I wanted to
test, but just not know how to write it up. My instinct was to just fire
up the browser and visibly test it.

Testing is one of the more obivous things that beginners struggle with,
but it's one of the things that separate the beginner from the advanced.

Rails
--------------------------------------------------------------------------------
Finally, alfter all that, we get to the thing we've wanted to learn (I
realize you can possibly skip some steps like deployment and testing).
I never really thinking rails was tough to learn, but it's just a giant
framework with tons of convienent helpers.  It just takes time to learn
it.  Similar to what I said about Ruby, you have to get used to the
error handling, docs, etc, but then there's a few other categories...

### Conventions
Conventions are awesome after you learn/know the convention, but before
you learn the convention, it's just another unknown.  I think all in
all, the majority of conventions in rails are a big help.  It's really
nice to see the same directory layouts in tutorials and to see similar
controller actions in beginner app as in an advanced app. 

### The Rails Way
It might have just been me, but I was so concerned about doing things
the right way, that I'd waste hours trying to figure something out that
I knew how to do, but didn't think it would have been "The Rails Way". I
suppose there's a balance that needs to be made. Sometimes it's
important to learn things the right way the first time and sometimes it
could be better to just do it and refactor later. 

### The Magic
It's been discussed, but a lot of the magic behind rails is
wonderful and some of it is harmful.  A lot of times you don't know why
or how something works, but you see others do it or find it in the docs
and it gets used. On reply to the tweet by @mislav said

> Rails is awful for beginners, especially those who don’t understand
> the set of problems that a framework like this solves for you 

The "magic" is a part of that disguise.  

### MVC
A MVC concept was was unfamiliar with to me. I didn't always understand
the role of the controller, model, views, helpers, etc.  What should go
where?  I'm not sure if routing really falls under MVC, but that was a
confusing concept too.  In PHP, you just upload the file and it works!

### DSL's and Gems
Rails is one big DSL and typically developing a rails application
involves learning many other DSL for necessary gems.  Devise,
formtastic/simple\_form, bootstrap/foundation, slim/haml, state\_machine,
cancan, kaminari, carrierwave, fog, delayed\_job/sidekiq are just a few
common gems in my Gemfiles.  All of them and more have to be learned.



Summary
--------------------------------------------------------------------------------
I hope that the people teaching rails will read this and understand a
little more about what a beginner is thinking.  I wish I'd have written
this in the early stages so I'd have a fresher memory of the struggles.
I'm sure teachers and instructors have their own memories and
reflections of when they first learned too, but hopefully another
perspective will help out.

Lastly, if you're new to rails or going through the learning process
now, I'd say don't get discouraged. If you really want to become a good
rails developer, it'll take time, experience and dedication. It's not
easy and you don't want it to be easy.  If it was easy, anyone could
pick it up and do it, which would make being a rails developer a
valueless commodity.

[1]:https://twitter.com/alindeman/status/435094591268585473
