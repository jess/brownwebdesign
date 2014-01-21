---
layout: post
status: publish
published: true
title: Find and replace html tags in a database
author: jess
author_login: jess
email: jess@brownwebdesign.com
author_url: http://www.brownwebdesign.com
wordpress_id: 284
wordpress_url: http://www.brownwebdesign.com/blog/?p=284
date: 2013-08-21 03:15:50.000000000 -04:00
categories:
- General
tags:
- rails
- refinery
- nokigiri
- cms
comments: []
---
I recently had a client want to change all h2 tags to h1 tags in a refinerycms app I managed.  They had several hunderd pages, so manually doing it was not sounding good and using regular expressions for html parsing sounded like trouble.

Then I thought of <a href="http://nokogiri.org/">Nokogiri</a>.  Nokogiri does a good job of parsing html right?  But how do I change the html?

I ended up writin a rake task searched the body parts (main content body for refinery) for h2 tags and then used Nokogiri to change the tags.

To change the tags, you can just `h2.name = "h1"`.  Another problem I ran into was that I was using

``` ruby 
Nokogiri::HTML(page.body)
```
But when I called `to_html` on it, I'd get the doctype and body tags with it.  Then I found you can use fragment:

``` ruby 
Nokogiri::HTML.fragment(page.body)
```

And that only retuned exactly what I wanted.

Check it out:

``` ruby
desc "Change body tags"
task :change_body_tags => :environment do
  puts "Changing Body Tags"
  body_parts = Refinery::PagePart.where(:title => "Body")
  body_parts.each do |body_part|
    body_part.translations.each do |page|
      doc = Nokogiri::HTML.fragment(page.body)
      doc.css("h2").each{|h2| h2.name = "h1" }
      page.body = doc.to_html
      page.save
      puts "Updated id # #{page.id}"
    end
  end
end
```
