---
author: Jess Brown
email: jess@brownwebdesign.com
title: Using the sanitize gem - Clean HTML
---

I recently had a need to sanatize html entered by users in an app.  The
app (<a href="https://www.csepub.com">www.csepub.com</a>) allowed
professors to enter homework assignments for their ebooks.  One type of
homework assignment is a written assignment.  The app needed to allow
the user/student to create and submit an assignment.  At first we were
using uploaded documents, but with thousands of students, this became a
heap of uploaded word docs.  Recently we decided to allow the student to
submit their assignment via html using an html editor (trimmed way down
to just basic text formatting).

My fear was that allowing this many people to enter html into my
database, that something might get wonked up.  I'm not a security
expert, but I figured I should be sanitizing the html.

After a bit of research I found the sanitize gem (<a
href="https://github.com/rgrove/sanitize">https://github.com/rgrove/sanitize</a>).
It does 2 basic things: 1) clean the html of unwanted tags and closes
any open tags.  Hopefully this won't be a problem for me because I'm
preventing the user from editing actual html with a slimmed down html
editor, but I don't want to take a chance.

The gem is pretty straight forward.  Just place it in your gem file and then bundle.

Next, in the AR model you want to store your html in, I added a 'before_save' hook.

```ruby
class AssignmentUpload < ActiveRecord::Base
  before_save :clean_html

  private
  def clean_html
    self.html = Sanitize.clean(html, whitelist)
  end
end
```
The biggest decision you have to make is which tags you want to
whitelist.  Sanitize has several pre built levels for you to use.
`Sanitize::Config::BASIC` looked like the option for me.  However, I
realized that I needed to allow a span tag with a inline style
(professors wanted to make notes to the assignments and highlight text).
I didn't want to recreate the pre setup from scratch, so I figured out
`Sanitize::Config::BASIC` is just a hash so I just slightly modified it.

```ruby
def whitelist
  whitelist = Sanitize::Config::BASIC
  whitelist[:elements].push("span")
  whitelist[:attributes]["span"] = ["style"]
  whitelist
end
```

