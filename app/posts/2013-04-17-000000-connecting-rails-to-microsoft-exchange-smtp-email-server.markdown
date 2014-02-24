---
title: "Connecting Rails to Microsoft Exchange / SMTP Email Server"
author: Jess Brown
email: jess@brownwebdesign.com
---
<p>When a client first asked me to switch from Sendgrid to use their smtp exchange server, I figured it'd be really simple...like connecting to a gmail account.  However, I ran into a few issues.  Like a lot in programming, it wasn't anything way different than what I was doing, but a couple to syntax differences.  Hopefully, someone will find find this helpful (surprisingly google didn't help me much with my searches).</p>

<p>So, here's the standard gmail setup:</p>

```ruby
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  :address        => 'smtp.gmail.com',
    :port           => '587',
    :authentication => :plan,
    :user_name      => ENV['SMTP_USERNAME'],
    :password       => ENV['SMTP_PASSWORD'],
    :domain         => 'brownwebdesign.com',
    :enable_starttls_auto => true
}
```

<p>Just a few small changes below to the authentication type.</p>

```ruby
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  :address        => 'smtp.office365.com',
    :port           => '587',
    :authentication => :login,
    :user_name      => ENV['SMTP_USERNAME'],
    :password       => ENV['SMTP_PASSWORD'],
    :domain         => 'congrueit.com',
    :enable_starttls_auto => true
}
```

Your `SMTP_USERNAME` should be your whole email address.

The other thing that got me was you need to send from the actual account
you're using to log in with.  For example, don't send email from
noreply@brownwebdesign.com and use support@brownwebdesign.com as your
`SMTP_USERNAME`.

<p>There may be some other setting on the exchange side that needs to be tweaked (smtp allowed, authentication, etc.), but I think my client had</p>

<h2>Debugging</h2>

<p>Maybe the more interesting this is how to debug it.  </p>

<p>The app isn&#39;t in production yet, but I tried it on the production server first; didn&#39;t work.  So, easy way never works.  Try in test/dev first I use <a href="http://mailcatcher.me">mailcatcher.me</a> in development mode, so I took the smtp settings (above) from <code>config/environments/production.rb</code> and placed them in <code>config/environments/development.rb</code></p>

<p>Then I made sure that <code>config.action_mailer.raise_delivery_errors = false</code> was set to true and that helped debug the reasons things were going wrong.  I got an error about wrong authentication type and then that my account didn&#39;t have permission to send (was using different from address).</p>
