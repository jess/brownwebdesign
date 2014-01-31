---
published: true
title: "Ruby: Equal Plus Not Equal to Plus Equal"
author: Jess Brown
email: jess@brownwebdesign.com
---

I was recency debugging an issue on an app.  I had my test setup and
properly failing.  I was debugging and narrowing it down to the correct
file.  I wasn't getting an error or exception, so the specific line
number wasn't known.  I just knew where the general error was.  

I scanned the file, only about 15 lines.  I was looping through to some
form fields and needed a counter like below:

```ruby
- if job_skill.id.blank?
  - key = "key#{id}"
  - id =+ 1
```

If you paid attention to the title or have a sharp, you might have
noticed the slight difference:

`=+ != +=`

I would have thought that `=+` would cause some sort of exception, but
it doesn't:

```
[1] pry(main)> i = 0
=> 0
[2] pry(main)> i =+ 1
=> 1
[3] pry(main)> i =+ 1
=> 1
[4] pry(main)> i =+ 1
=> 1
[5] pry(main)> i += 1
=> 2
[6] pry(main)> i += 1
=> 3
[7] pry(main)> i += 1
=> 4
[8] pry(main)> i += 1
=> 5
[9] pry(main)>

```

So, as you can see, my first two results were as expected, but then all
future results overwrote the 2nd.  

Nice little gotcha to watch out for!
