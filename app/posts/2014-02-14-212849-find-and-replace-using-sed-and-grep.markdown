---
title: Find & Replace Using Sed & Grep
author: Jess Brown
email: jess@brownwebdesign.com
---

I recently had a client who needed to change the phone number across the
site.  I didn't build the site, but I quickly found out the previous
developer didn't use any variables or partials.  The phone number was
scattered throughout several hundred static files across the site.  

Luckily I had shell access to the server, so I just needed a script to
find and replace all the files.

I had already grep'ed the files which told me the phone number was
littered throughout the site files:

    grep -r 555-555-5555 ./

Now I just needed a way to replace that number with the new one.  Sed to
the rescue.

    grep -rl 555-555-5555 | xargs sed -i 's/555\-555\-5555/444\-444\-4444/g'

There you go, several hundred files changed at once.
