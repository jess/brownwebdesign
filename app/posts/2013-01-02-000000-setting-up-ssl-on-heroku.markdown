---
author: Jess Brown
email: jess@brownwebdesign.com
title: Setting Up SSL on Heroku
---

I really love Heroku.  The simplicity and beauty of how it all works
just makes me happy.  However, unlike most of their
instructions/documentation, I recently ran into a bit of trouble when
setting up a custom domain ssl.  Looking back on it, it wasn't all that
big of a deal, but here's a few details in what I had to do to get it
working.

First, know that you can always use <a
href="https://devcenter.heroku.com/articles/ssl">heroku's free ssl</a>
with your-app.herokuapp.com, but if you want https://www.yourapp.com,
you have to pay the $20/mo fee and setup the <a
href="https://devcenter.heroku.com/articles/ssl-endpoint">SSL Endpoint
Add on</a>.

I followed the directions here:  <a
href="https://devcenter.heroku.com/articles/ssl">https://devcenter.heroku.com/articles/ssl</a>

Everything was heroku smooth until I got to the upload certificate part.
Every time I tried to upload the certificate, I got an error.  I've
setup a few servers using ssl and felt pretty confident that I was using
the right certificates/keys/etc.  After a bit of trying and failing, and
googling, I remembered in the last nginx server I setup for ssl I came
across documentation for <a
href="http://wiki.nginx.org/HttpSslModule">root certificates</a>:

> if you have a chain of certificates — by having intermediate
> certificates between the server certificate and the CA root certificate
> — they're not specified separately like you would do for Apache. Instead
> you'll need to concatenate all the certificates, starting with the
> server certificate, and going deeper in the chain running through all
> the intermediate certificates. This can be done with "cat chain.crt >>
> mysite.com.crt" on the command line. Once this is done there's no
> further use for all the intermediate certificates in what Nginx is
> concerned. You'll indicate in the Nginx configuration the file with all
> the (concatenated) certificates.

I decided to give it a try.  I mostly use <a
href="https://dnsimple.com">www.dnsimple.com</a> for ssl certs ($20
bucks!) and they use RapidSSL.  So I downloaded the rapidssl_bundle.pem
file and concatenated it to the bottom of the server cert.  Then
<code>heroku certs:add server.crt server.key</code> worked just fine!

The other area I'm still a bit confused about is the "Configure DNS"
section.  You'll need to add (or change if you already have setup) your
CNAME record to point to the new ssl endpoint add on that heroku creates
when you successfully add your keys.  What's not clear is if you still
want to serve regular http traffic to certain parts of the app, does it
still work??  The app I did this on we use https all the time, so it
wasn't an issue, but I'm curious about the non https and how it works.

**Update** <a href="https://twitter.com/mattmanning">Matthew Manning</a>
@ Heroku was kind enough to read my article and answered my question.
"Yes. A SSL endpoint can be used with both secure (https) and insecure
(http) traffic."  Thanks!

*NOTE:*  It's been a few weeks since I ran into this trouble and now that
I'm wring the blog article I wanted to try and recreate the error.  My
app still isn't live, and so as to avoid the $20 charge on another app,
I just removed the keys and was going to try and re upload the cert
only. It actually worked this time without the pem (no error).  I'm not
sure if this is because heroku still had something in cache or what??
However, even though it worked, when I previewed my certs <code>heroku
certs</code> I got:

```
Endpoint                 Expires               Trusted
-----------------------  --------------------  -------
nara-2279.herokussl.com  2013-12-11 17:40 UTC  False</pre>
```

Only when I updated and used my concatenated cert did it work, so
regardless of whether you get the error or not, you will need to cat the
certs.

<a href="https://twitter.com/mattmanning">@mattmanning</a> also gave me
this advice: You might also want to mention the SSL Doctor client
plugin, which can complete the chain of trust for you automatically. <a
href="https://github.com/heroku/heroku-ssl-doctor">https://github.com/heroku/heroku-ssl-doctor</a>
