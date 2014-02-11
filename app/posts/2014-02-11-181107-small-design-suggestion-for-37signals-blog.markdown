---
title: Small Design Suggestion For 37signals Blog
author: Jess Brown
email: jess@brownwebdesign.com
---

I just recently redeisgned my blog and one of the blogs I drew
inspiration from was the [37Signals Blog Signal vs. Noise][1].

So I'm fairly familer with their styles (font, size, color, width, line-height, etc).  One thing I noticed today while reading an article was their images seem off alignment:

![Off alignment image][2]

I'm not sure if this was intentional or an oversight (or maybe the
writer forgot to apply a class), but I figured I'd write it up and tweet
it out to see if my sugggestion would be well received.  

The issue is on their paragraphs, they have a `text-indent` set:

```css
.post-content p + p {
  text-indent: 2em;
}
```

For most of their images on [this page][3], they're the first and only
content in the paragraph tag, so the images are being indented too,
which causes the left edge to be indented, but also the right edge to
push past the normal paragraph's width.  

They could override the paragraph's `text-indext` for the image like
this:

```css
.post-content p img {
  margin-left: -2em;
}
```

This will negate the 2em paragraph indent and slide the image over even
with the left and right sides of the paragrahp text:

![Images Fixed][4]


[1]:http://signalvnoise.com/
[2]:/images/blog/37signals-blog.jpg
[3]:http://signalvnoise.com/posts/3715-prophet-my-first-commercial-web-site-design-project-1996
[4]:/images/blog/37signals-blog-fixed.jpg
