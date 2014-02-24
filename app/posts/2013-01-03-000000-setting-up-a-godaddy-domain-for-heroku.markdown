---
title: Setting Up A Godaddy Domain for Heroku
author: Jess Brown
email: jess@brownwebdesign.com
---
If you have a client using Godaddy, here's a quick tip for setting up a Godaddy domain for heroku.  

<pre lang="ruby">
 heroku domains:add www.example.com
</pre>

That's easy enough to go into Godaddy's DNS manager and add a cname for www and link it to your heroku domain <code>example.herokuapp.com</code>.  

But, heroku doesn't support naked domains (<code>example.com</code>).  Some providers like <a href="http://dnsimple.com">DNSimple</a> provide an alias for a naked domain.  The next best thing is a forwarder.  After setting up your CNAME record, exit out and find the link to turn forwarding on.  Then, forward example.com to www.example.com (default is 301 permanent...you want that).  Now you're good to go!
