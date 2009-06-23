class Admin::PostsController < ApplicationController
  
  layout 'admin'
  
  def index
    @posts = Post.find(:all)

    respond_to do |format|
      format.html
    end
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_post_path(@post) }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
