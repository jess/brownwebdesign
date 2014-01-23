---
status: publish
published: true
title: Rotating rails' logs
author: Jess Brown
email: jess@brownwebdesign.com
---


A few nights ago, I had a rails app running really slow.  Users were
complaining and sending support tickets to my client.  Not my favorite
message to get at 11pm!

For reference, it is a rails app, running on unicorn and nginx all on
Ubuntu 10.1

One of the first things I did was ssh into the server and ran `$ top`
which will give you a brief overview of the system vitals like memory usage,
server load, and top processes.  The server load is usually most useful
to me.  I'm not sure how it works but it's a scale starting with 0.  0-1
and your server is basically idle.  1-3 and your server is humming along
fine.  When you start getting over 5, your server is probably running
noticeably slow.  Well, I've seen this number creep up to 15-20 on other
servers in the past, this night I was only at a 4-5 range.  

The next thing I did was to take a look at the logs.  I did an `$ ll -h`
to see what was going on in the direct and got this:

```
total 1.1G
drwxrwxr-x  2 user group 4.0K 2014-01-23 06:25 ./
drwxrwxr-x 12 user group 4.0K 2012-08-20 08:07 ../
-rw-r--r--  1 user group 1.1G 2014-01-22 06:25 production.log
-rw-r--r--  1 user group  17M 2014-01-22 12:22 unicorn.log
```
<span style="font-size: 80%; font-style: italic;">(*I changed the real user/group name with generics to protect my
client's and server's idenity)</span>

Whoops, I don't think that log should be quite that large.  Each time
rails has to write to the log, it is having to deal with a 1G file.  I'd
actually manually rotated this log, but it was now time to find
something more automated.

After checking around a bit, I [found this article] [1] on stackoverflow
talking about a command that I assume comes with most Ubuntu
installations called autorotate.

It's actually easy to setup.  I just created a file in the
`/etc/logrotate.d/` directory.  This is a config file for autorotate.
Mine looked like this:

```
# /etc/logrotate.d/app_name
# Rotate Rails application logs based on file size
# Rotate log if file greater than 20 MB
/home/user/apps/app_name/current/log/*.log {
    size=20M
    missingok
    rotate 52
    compress
    delaycompress
    notifempty
    copytruncate
}
```

So it just basically rotates the log when it gets to 20M.  

One thing I was unsure of was how the new config would take effect.  Did
I need to restart the logrotate servce or add the config?  It seems that
logrotate is cron job run by the system, so you don't need to do
anything.  It'll just start working.  

The other question I had was, where do find the rotated log files?  In
my case, they were placed in the same directory as the main log file,
which was fine because it was sym linked to a 'shared' directory in
within my rails app setup.  

Now my log direct looks like this after a few days:

```
total 61.5M
drwxrwxr-x  2 user group 4.0K 2014-01-23 06:25 ./
drwxrwxr-x 12 user group 4.0K 2012-08-20 08:07 ../
-rw-r--r--  1 user group 135K 2014-01-23 09:28 production.log
-rw-r--r--  1 user group  43M 2014-01-23 06:25 production.log.1
-rw-r--r--  1 user group 1.5M 2014-01-22 06:25 production.log.2.gz
-rw-r--r--  1 user group  17M 2014-01-22 12:22 unicorn.log
```

Hope this helps...feel free to ask questions!
[1]: http://stackoverflow.com/questions/4883891/ruby-on-rails-production-log-rotation/4883967#4883967
