---
title: Reformatting With Vim
author: Jess Brown
email: jess@brownwebdesign.com
---

<div class="flex-video widescreen"><iframe width="560" height="315" src="//www.youtube.com/embed/SHXHmJKe7dw" frameborder="0" allowfullscreen></iframe> </div>

If you're using markdown a lot with vim, you may have run into an issue
with formatting. After you type a paragraph, then go back to edit, the
auto softwrap that happens, get's off when you add or delete text.

This used to drive me nuts, until I found a simple fix. `gq` will
reformat the line and reset the wrapping. Most of the time, you'll need
to fix the whole paragraph because any edits typically effect lines and
words afterwards as well. So, you can select the whole paragraph and
reformat with `vipgq`.

I ended up wrapping this to a shortcut:

    # .vimrc
    map <leader>al vipgq
    
