---
published: true
title: Setting the server clock time and keeping it correct on ubuntu
author: Jess Brown
email: jess@brownwebdesign.com
---

I'm working on a university exam taking application and needed to make sure the clock on the server was properly set so students don't get upset that they didn't make the due date.

When I checked the server clock, it was correctly set for the time zone, daylight savings time and hour, but the minutes were off.

A couple of google searches talked about syncing the server with a
server pool.  That sounded pretty complicated, but time has to remain
correct, right??

It actually turned out pretty simple.  I used [this blog article][1], but it boils down to a few easy steps:


```
sudo apt-get install ntp

```

Yep, that's it.  You can change the config for the server pool if you
like (see blog above), but that's pretty much it!

[1]:https://www.digitalocean.com/community/articles/how-to-set-up-time-synchronization-on-ubuntu-12-04
