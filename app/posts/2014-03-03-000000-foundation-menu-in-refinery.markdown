---
title: Foundation Menu In Refinery
author: Jess Brown
email: jess@brownwebdesign.com
---

The sign of a good open source platform is when you want to do
something outside the box, how easy is it to modify.  Well Rails and
Ruby are particularly good candidates and Refinery doesn't hold them
back.

I was recently building a [Refinery CMS][] and was using [Zurb
Foundation][] for the front end framework. If you've used Foundation
before, you'll know that the top menu requires specific markup and
unlike many of the other components, doesn't have mixins that you can
use to implement it.

My menu needed to look something like this:

```html
<section class="top-bar-section">
    <!-- Right Nav Section -->
    <ul class="right">
      <li class="active"><a href="#">Right Button Active</a></li>
      <li class="has-dropdown">
        <a href="#">Right Button with Dropdown</a>
        <ul class="dropdown">
          <li><a href="#">First link in dropdown</a></li>
        </ul>
      </li>
    </ul>
</section>
```

The Refinery menu html looked like this:

```html
<nav class="menu clearfix" id="menu">
  <ul>
    <li class="selected first"><a href="/">Home</a></li>
    <li class="last"><a href="/about">About</a></li>
  </ul>
</nav>
```

In the past, Refinery had used view partials to implement the menu, but
in an effort to clean the code up and make the menu more efficient, they
changed it to a presenter.  Now Refinery uses this one call from a view
to to implement the menu:

```eruby
<%%= Refinery::Pages::MenuPresenter.new(refinery_menu_pages, self).to_html %>
```

I didn't immediately know the best way to solve this, so I fired off a
quick [Github comment] and one of the primary maintainers immediately
wrote me back (testament to their responsiveness). He said, just
subclass it and overwrite the methods.

That actually turns out easier than it sounds.  Just create a new file in
`app/models/foundation_menu.rb`.


```ruby
class FoundationMenu < Refinery::Pages::MenuPresenter
end
```

Now we can start overwriting the methods we need. The first is the
render menu method:

```ruby
class FoundationMenu < Refinery::Pages::MenuPresenter
  def render_menu(items)
    content_tag(:section, :id => "nav", :class => 'top-bar-section') do
      render_menu_items(items)
    end
  end
end
```
Here's the diff on that method:

<a href"#" data-reveal-id="render_menu_diff"><%= image_tag "blog/render_menu_diff.jpg" %></a>
<span class="footnote">Click to enlarge</span>

<div id="render_menu_diff" class="reveal-modal" data-reveal>
  <p class="text-center"><%= image_tag "blog/render_menu_diff.jpg" %></p>
  <a class="close-reveal-modal">&#215;</a>
</div>

As you can see, we're just slightly changing the methods.  Here we
changed the `content_tag` to be a section instead of a nav, the id to be
nav instead of default one and the class to `top-bar-section`

There's a few more changes that need to be made and one addition to get
the dropdown menu working. I'll link to it here so you can use it if you
like.  [Refinery Foundation Menu][]

Once you have your subclassed menu presenter in place, no you just need to link it up in your view:

```eruby
# app/views/refinery/_header.html.erb
<div class="row">
  <div class="columns large-12">
    <nav class="top-bar" data-topbar>
      <ul class="title-area">
        <li class="name">
          <%%= link_to image_tag( "logo.jpg" ), refinery.root_path, width: 100, height: 75 %>
        </li>
        <li class="toggle-topbar menu-icon"><a href="#">Menu</a></li>
      </ul>
      <%% menu = FoundationMenu.new(refinery_menu_pages, self) %>
      <%% menu.max_depth = 1 %>
      <%%= menu.to_html %>
    </nav>
  </div>
</div>
```
<span class="footnote">It'd probably be cleaner to extract this out to a
heleper or in ApplicationController</span>

Having a system that is flexible and easy to extend and override is awesome for a
programmer. I've built quite a few projects using Refinery CMS and I
continue to be happy with that I can accomplish.

[Refinery CMS]:http://refinerycms.com/
[Zurb Foundation]:http://foundation.zurb.com/docs/
[Github comment]:https://github.com/refinery/refinerycms/commit/b507ee5a16d46bbc57400b388e204c7f20101231#commitcomment-5452012
[Refinery Foundation Menu]:https://gist.github.com/jess/9270729
