---
title: "Back Everything UP: Don't get caught with your pants down"
author: Jess Brown
email: jess@brownwebdesign.com
---

### History

When I first started my company in 2008, my backup plan was simple:  I
had an external hard drive and I just backed up to it once a week.  

After I while that started to become too much of a burden, and I had
also setup a Ubuntu dev server that I wanted to try backing client work
up to. So I followed this popular article about setting up  [TimeMachine on
Ubuntu](http://kremalicious.com/ubuntu-as-mac-file-server-and-time-machine-volume/) and it worked great.  Then Rack Space bought a little company called Jungle Disk and they had an option for Unbuntu to backup files to S3 or Rackspace's cloud files for an off site solution.

This worked really well because I had everything in one place and lots of redundancy.  I had a 2nd hard drive in the dev server that I rsynced to.  I also had another computer in the office that I rsynced to, and I had the offsite backup in case of fire, theft, flood, etc.  

### What changed?

In 2009, I really started to get into rails development which works
best when you have your files locally.  You run a local web server,
local database server, Git (git is slow over a network for large
projects) and things just work better in my local env.  Also, I started
using Dropbox a lot and enjoyed how easy it was to share files/folders
and also came with the convenience of backing up your files
automatically in the background.  Around that time I also ordered a new
dev server with a RAID setup to mirror the data.

This is when things started to get a little off.  After setting up my
new server, I never resetup  JungleDisk.  We started putting all
new client directories in Dropbox.  We ended up with having a lot of old client data on the server, some internal applications (ie billing/time tracking) and lots of old resources (images, videos, etc).  

I've had it on my todo list for sometime now to find an offsite solution
for my dev server, and I've looked a few times, but just haven't found
anything that seemed to fit for what I wanted.

### No OS Found

My wife and I take turns each day exercising.  Once day she does
CrossFit and the next I ride my bike.  On Friday's (her day) the
CrossFit class is a later in the morning and I usually take some time to
hang out with my 3 year old Nate.  We were about to go and see my 93 year old
grandfather and I was trying to get a deposit ready in the
office when Nate came in and simply pushed the power button on my
battery backup for the dev server.  

I got a little flustered, ushered him out and didn't think much of it
(thinking it would reboot itself as it has before after long power
outages).  Later that afternoon, I went to enter so time in my time
tracking app and it wouldn't come up.  That's when I went to the server
turned the monitor on and saw **No OS Found**.  

I instantly started to get a little nervous.  I rebooted and rebooted
several time and tried going into the setup and RAID setup and had no
luck.  

This is when the regret started puring in and I started kicking myself
in the rear.  How difficult would it have been to just have a simple
local copy on one of the other 5-6 machines I have around the office?
It wouldn't have taken any more time than to write this article.  

### The Outcome

I was fortunate that I hadn't lost any client work.  I did have a few
old client directories that had some graphic source files, but the
biggest thing was a months worth of billing / time tracking.  How could
I ever I recreate that?  

This happened on a Friday night, so I couldn't take it immediately
anywhere.  I was going to wait until Monday, but my anxiety got the
best of me and I took it to a place that had done good work for me
before, but after taking a quick look, they said it'd be Monday before
then had any answers.  

Well, this made for a really crumby weekend.  

Finally on Monday (afternoon) I got the answer I'd been looking for:  my
data was safe.  There was actually nothing wrong with the hard drives.
If we turned off the RAID controller in the BIOS, you could boot the
drives fine (so they were perfectly mirrored), but something got messed
up with the RAID configuration and it was no longer recognized.  You
have to erase the HD's to redo the configuration, so I immediately picked
up the computer to make backups!


### The Takeway

Don't get lazy and slack about your backups...it's easy to do over time,
especially if you haven't had a scare in a while.  Also, with all the
focus on the cloud (Dropbox, Google Apps, S3, etc), it's easy to
distance yourself and be naive about how covered you are.  I incorrectly
felt way too comfortable about the RAID setup and figured I had good
coverage and I was very close to being WAY wrong.  

Take backing up seriously and don't just rely on one source and/or
service.
