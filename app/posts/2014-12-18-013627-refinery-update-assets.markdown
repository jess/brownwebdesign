---
title: Auto Update Assets In Refinery
author: Jess Brown
email: jess@brownwebdesign.com
---

Refinery uses the [Dragonfly][1] gem to upload images and files. It's a
really nice gem, but there is a problem when using it in RefineryCms.
The problem is, that every time you update an image or file with
Dragonfly, you get a new url to the asset. Dragonfly uses a job id in
the asset url to encode the path to the image. So the image url may look
like:

`/system/resources/W1siZiIsIjIwMTQvMTEvMjYvMThfMTZfMjdfNzA4X3Rlc3QucGRmIl1d/test.pdf`

and the path to the image is would look like
`2014/11/26/18/16/27/708/test.pdf`, which you'll see is a directory path
of a timestamp. 

### So what's the problem?

If you link to this pdf in 10 pages of content, and later someone comes
up with an edit to the pdf, you'll need to reupload the pdf, which will
generate a new link to the pdf and break all of the links to the old
version. This is really annoying because people like to update pdf's and
images quite frequently and are used to updating the file or image
without breaking the links.

### How to fix?

Originally I tried to figure out a way to configure Dragonfly so that it
would not regenerate the path or that maybe it would not use such a
specific timestamp method of creating the directory. I could not figure
this out. Plus, if do you that, then you still have an issue with
caching, especially if you're using a CDN like [CloudFront][2] (note the
remark about fingerprinting if you visit the link). 

Then I had a thought. What if we just automated the updating of links
each time an asset was updated? Well, I started exploring and it turns
out it's pretty easy. Here's how it works.

First you need an `after_update` hook for the Resource (files) and Image
models. Since these models are in the refinery gem, the best way is to
use a decorator:

```ruby
# app/decorators/models/refinery/image_decorator.rb
Refinery::Image.class_eval do
  include UpdateAssetReference
end

# app/decorators/models/refinery/resource_decorator.rb
Refinery::Resource.class_eval do
  include UpdateAssetReference
end
```
I created a concern here so we're not duplicating the content in both
models:

```ruby
# app/models/concerns/update_asset_reference.rb
module UpdateAssetReference
  extend ActiveSupport::Concern
  
  included do
    after_update :update_asset_references
  end

  def update_asset_references
    AssetUrlReplacer.new(self).update_asset_references
  end
end
```

In the concern, all we do is create the `after_update` hook and then
pass in the instance of the file or image model to the AssetUrlReplacer,
which is where all the real work is done.

```ruby
# app/models/asset_url_replacer.rb
require 'nokogiri'

class AssetUrlReplacer
  attr_reader :asset

  def initialize(asset)
    @asset = asset
  end

  def asset_type
    if asset.is_a?(Refinery::Image)
      "image"
    else
      "file"
    end
  end

  def asset_name
    asset_type + "_name"
  end

  def references
    Refinery::PagePart::Translation
        .where("body like ?", "%#{asset.send(asset_name)}%")
  end

  def update_asset_references
    references.each do |translation|
      html = Nokogiri::HTML.fragment(translation.body)
      replace_attributes(html, "a", :href)
      replace_attributes(html, "img", :src)
      translation.body = html.to_html
      translation.save
    end
  end

  def replace_attributes(html, tag, attribute)
    if (tags = html.css(tag)).any?
      tags.each do |element|
        if element[attribute].include?(asset.send(asset_name)) 
          && element[attribute].include?("/system/resources/")
          element[attribute] = asset.send(asset_type).url
        end
      end
    end
  end
end
```

Since the resource and image models use different method names to get
the image url, we have to do a little meta programming. Other than that,
the logic is rather straight forward. First we search for any references
to the asset's file name. Then we loop through those records and search
for either links or images that are referencing the file name. If
there's a match, we update the html and save the record. We use nokogiri
to parse the html so we don't have 

That's it. Now whenever a client updates their files or images, they
will be replaced in the content if they are referneced there. 

What do you think? See any issues??


[1]:https://github.com/markevans/dragonfly
[2]:https://devcenter.heroku.com/articles/using-amazon-cloudfront-cdn
