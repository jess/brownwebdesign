---
title: Adding A Custom Field In Refinery
author: Jess Brown
email: jess@brownwebdesign.com
---

If you're a developer, you're always wanting to tweak and configure
things to your liking. This is one reason I love working with Refinery
CMS.

I was recently building a CMS for a client and in the design there was a
main image at the top of the page:

<%= image_tag("blog/hardlabor.jpg") %>

I wanted my client to easily be able to swap this image out for another
if they wanted. I wanted a field on the Admin > Edit Page screen that
allowed control of this image.  Refinery made this easy to do.  Here are
the steps I took to do it.

#### Add the field


    rails g migration AddMainPhotoToRefineryPages main_photo_id:integer
    rake db:migrate

Here we're creating a field in the main `refinery_pages` table and it's
a foreign key. The foreign key will link to an image we add to the
`refinery_images` table, which is making use of Refinery's existing
method of handling images.

#### Update the admin form

To update the Admin > Edit Page form, you just need to override the
view:

    rake refinery:override view=refinery/admin/pages/_form

Now open `app/views/refinery/admin/pages/_form.html.erb` and add the
below code to your form (I added it underneath the
"form\_fields\_after\_title" partial)

```eruby
<div class="field">
  <%%= f.label :main_photo %>
  <%%= render :partial => "/refinery/admin/image_picker", :locals => {
    :f => f,
    :field => :main_photo_id,
    :image => f.object.main_photo,
    :toggle_image_display => false
  }
  %>
</div>
```

#### Permit the field

I'm using Refinery on Rails 4 which uses strong\_parameters, so we need
to permit this field so it will be accepted in our create and update
actions. To do this we can make use of Refinery's decorators. Create a
new file
`app/decorators/controllers/refinery/admin/pages_controller_decorator.rb`
and insert this code:

```ruby
Refinery::Admin::PagesController.class_eval do
  def page_params
    params.require(:page).permit(
      :browser_title, :draft, :link_url, :menu_title, :meta_description,
      :parent_id, :skip_to_first_child, :show_in_menu, :title, :view_template,
      :layout_template, :main_photo_id, parts_attributes: [:id, :title, :body, :position]
      )
  end
end
```

Here we're just overwriting the method in Refinery's admin pages
controller that defines the page params allowed and we're adding our
`:main_photo_id` field to it.

#### Setup the relationship in the model

Now we just need tell rails what to relate the `main_photo_id` field to.
We can do that with a simple `belongs_to`. Create a new file
`app/decorators/models/refinery/page_decorator.rb`

```ruby
Refinery::Page.class_eval do
  belongs_to :main_photo, :class_name => '::Refinery::Image'
end
```

<%=image_tag("blog/mainphoto.jpg") %>

Now we have a simple field we can use to add or remove the image.
There's just one more step: we need to specify how we want that image to
show up in the view.

#### The Display

Depending on your design, there's lots of ways you could use the image
we saved in the admin, but here's how I did it.

If you don't already have the show page overridden, go ahead and
override it:

    rake refinery:override view=refinery/pages/show

Now open `app/views/refinery/pages/show.html.erb` and place this code
where it belongs on your page:

```eruby
<%% if @page.main_photo.present? %>
  <%%= image_tag(@page.main_photo.url) %>
<%% end %>
```

That's it! Let me know if you have any questions.
