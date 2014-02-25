---
author: Jess Brown
email: jess@brownwebdesign.com
title: Read The Code
---
Several monts ago, John Nunemaker bloged "[Stop Googling][]". It was
about reading the code in an open source project oppsed to Googleing it.
He was a bit funstrated at someone who Googled, polled friends, and
basically searched everywhere besides the source to look for an answer
for their problem. 

Today I found out the hard way how right he was. I was trying to access
the object info passed along to a `delayed_job` record. I googled for 30
or 45 minutes trying to find an answer and couldn't get any bites. I
knew the handler field had the info I needed, but it was a string. I
also knew that somehow that info had to be extracted when my job was
processed. Finally on a whim, I looked to the source code. In the
second file I opened, I found a method called `payload_object`.

```ruby
def payload_object
  @payload_object ||= deserialize(self['handler'])
end
```

I saw object, deserialize, and handler. That's all I needed to know.
It was exactly what I wanted. It took less than a minute. I tried it
out and that was it.

That's when I remembered John's blog. Note to self: if a quick google
search doesn't display the obvious answer...**LOOK AT THE
CODE!**

[Stop Googling]:http://railstips.org/blog/archives/2010/10/14/stop-googling/
