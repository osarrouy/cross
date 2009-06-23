class Admin::GalleriesController < ApplicationController
  
  layout 'admin'

  def index
    @galleries = Gallery.find(:all)

    respond_to do |format|
      format.html
    end
  end
  
  def show
    @gallery = Gallery.find(params[:id])
    
    respond_to do |format|
      format.html
    end
    
  end
  
  def new
    @gallery = Gallery.new

    respond_to do |format|
      format.html
    end
  end
  
  def create
    @gallery = Gallery.new(params[:gallery])

    respond_to do |format|
      if @gallery.save
        format.html { redirect_to admin_gallery_path(@gallery) }
      else
        format.html { render :action => 'new' }
      end
    end
    
  end
  
  def edit
    @gallery = Gallery.find(params[:id])
    
    respond_to do |format|
      format.js
    end
  end
  
  def update
    @gallery = Gallery.find(params[:id])

    respond_to do |format|
      if @gallery.update_attributes(params[:gallery])
        params[:gallery].each_key { |key| params[:attribute] = key }
        format.js
      else
        format.js
      end
    end
  end
  
  def destroy
    @gallery = Gallery.find(params[:id])
    
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to admin_galleries_path }
    end
  end
  
end
