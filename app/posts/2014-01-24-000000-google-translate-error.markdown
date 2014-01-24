---
status: publish
published: true
title: This page is in Tagalog Would you like to translate it?
author: Jess Brown
email: jess@brownwebdesign.com
---


I got a call from a client that reported a strange notification from
Google Chrome:

![This page is in Tagalog  Would you like ot translate it?][1]

It's a feature/function of Google Chrome that will try to guess what language the page is in and then match it to the user's default language. So for example, if an English speaker went to an obvious French site, the same thing would pop down and say the page was in French, would you like to translate it?

What's surprising is that apparently there's a language called Tagalog (did you know??), but, what's confusing is why Chrome thinks this page is written in Tagalog. I hid most of the page, but it just a few simple sentences and some table data.

This is really an issue with Chrome, but after doing a little research, I found I can add some meta tags in to "hint" to Chrome that the site is in English.

I found [ this page on SO ][2] that discusses the same problem. I'm going to try and add these meta tags in:

```html
<meta name="google" content="notranslate" />
<meta http-equiv="Content-Language" content="en_US" />
```

Hopefully it'll work. Know any other tips??

[1]:/images/blog/tagalog.png
[2]:http://stackoverflow.com/questions/2980520/how-to-specify-your-webpages-language-so-google-chrome-doesnt-offer-to-transla
