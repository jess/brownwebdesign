---
title: Debug JS Comple Errors on Heroku
author: Jess Brown
email: jess@brownwebdesign.com
---

### ExecJS::RuntimeError: SyntaxError: Unexpected token punc «,», expected punc «:» (line: 1559, col: 7, pos: 56557)

Recently ran into this issue on Heroku and found a a great answer on
Stack Overflow I wanted to share how it works:


<div class="flex-video widescreen"><iframe width="560" height="315"
src="//www.youtube.com/embed/HEFEX8-XZBQ" frameborder="0"
allowfullscreen></iframe> </div>

Here's the link to the Stack Overflow article:

[https://stackoverflow.com/a/38605526](https://stackoverflow.com/a/38605526)

Here's the one liner:

```ruby
JS_PATH = "app/assets/javascripts/**/*.js"; Dir[JS_PATH].each{|file_name| puts "\n#{file_name}"; puts Uglifier.compile(File.read(file_name)) }
```
