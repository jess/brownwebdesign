---
title: Testing And Designing Email Views in Rails
author: Jess Brown
email: jess@brownwebdesign.com
---

### The Problem

The traditional way of testing the design of emails in rails has always
seemed really lame.  Way back when, we had to connect to some an 
smpt server in development, then trigger the email and then pull up the
email to check it.  More recently, tools like
[mailcatcher](http://mailcatcher.me) and [letter
opener](https://github.com/ryanb) came about and eliminated the need to
actually connect to an email server and send the email. 

However, this still isn't very rails like.  You have to setup the
scenario and sometimes they're really long.  For example:

1. create a user
2. verify user
3. certifiy user
4. user receives and an invitation to by a customer (need a customer)
5. user decides to bid on project
6. customer awardes the bid to the user
7. finally "bid awarded" email gets triggered

Wait, you made a change, now repeat all of that.

### A Solution:  The MailView Gem



