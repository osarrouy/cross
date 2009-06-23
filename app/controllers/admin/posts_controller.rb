class Admin::PostsController < ApplicationController
  
  layout 'admin'
  
  def index
    @posts = Post.find(:all, :order => "created_at DESC")

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
        format.html { redirect_to admin_posts_path }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to admin_posts_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_path }
    end
  end

end
