class PostsController < ApplicationController
  
  layout 'public'

  def index
    @posts = Post.find(:all, :order => "created_at DESC")
    
    respond_to do |format|
      format.html
    end
  end

end
