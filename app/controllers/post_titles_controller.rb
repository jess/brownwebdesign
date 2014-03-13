class PostTitlesController < ApplicationController
  layout 'blog'
  def index
    @posts = Post.visible
  end
end
