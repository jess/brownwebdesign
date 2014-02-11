---
title: Simple Rails Blogging With Vim & Markdown
author: Jess Brown
email: jess@brownwebdesign.com
---

I've had a wordpress blog for about 5 years.  I've never really been
serious about blogging, which is a real shame because I've learned so
much about rails and web development over the years, there's tons I
could have shared (plug for anyone to start blogging).  Anyhow, over the
last year or two, I've really wanted to get more into blogging and
writing.  There's so much potential that can come from it.  Learning
more about the topic you're writing about, communication skills,
building an audience, marketing, SEO, building credibility, are just a
few to start.  I was recently listing to the [Thought Bot podcast][1]
and heard an interview with Nathan Berry where he discussed his [ goal
of writing 1000 words everyday ][2] and also talked about building an
audience.  I was inspired and decided I had to get something
started. 

However, my geek side wanted something cool and convenient to write
with.  I'm a vim user, love markdown, and am loyal to git, so I knew I
wanted to use those tools.  My known options were pretty much limited
to, Octopress, Jekyll, and Middleman.  I'd tried Octopress and Jekyll
before and didn't really get along with them (was also inexperienced
with them) and I never really gave [ Middleman ][6] a chance.  Before
middleman came out, I was using and contributing to [Serve][5] a lot and
I just didn't want to relearn Middleman.  I just kept asking myself,
"I'm a rails developer, why can't I use rails to blog?"  I also had some
notions to maybe add some functionalty for things like client login,
intergrate my time tracker, invoicing, etc, and rails would have been my
obvious choice for that.

Well, I finally came across a gem called [postmarkdown][3].  It's a
"A simple Rails blog engine powered by Markdown".  So I tried it out and
I was hooked on making it work.  

My website and blog are [ opensourced ][4] so I hope you'll check out
out.  I'll give the details on my blogging workflow below.

Fire up my terminal and to create a new post:

    rails generate postmarkdown:post my-new-title

That generates a markdown file in `app/posts`.  Then I open in vim and
like to use a vim plugin called [Goyo][7] for a write-room like
experience:

![Goyo Screenshot][8]

After finishing writing, it's just:

    git commit ...
    rake deploy

I could (and probably will) write a lot more about what's going on
behind the scenes technically, but I mainly just wanted to give a brief
overview on the setup and about a developer trying to make a habit of
writing!

Until later, free to use the [github repo][4] to play around with.

Let me know if you have any questions.




[1]:http://podcasts.thoughtbot.com/giantrobots/72
[2]:http://nathanbarry.com/365/
[3]:https://github.com/ennova/postmarkdown
[4]:https://github.com/jess/brownwebdesign
[5]:http://get-serve.com/
[6]:http://middlemanapp.com/
[7]:https://github.com/junegunn/goyo.vim
[8]:/images/blog/goyo.png
