class Admin::PhotosController < ApplicationController
  
  def index
    @gallery = Gallery.find(params[:gallery_id])
    @photos = @gallery.photos
    
    respond_to do |format|
      format.js { render :partial => '/admin/galleries/photos'  }
    end
  end
  
  def new
    @gallery = Gallery.find(params[:gallery_id])
    @photo = Photo.new
    
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @gallery = Gallery.find(params[:gallery_id])
    @photo = @gallery.photos.build(params[:photo])

    respond_to do |format|
      if @photo.save
        format.html do
          responds_to_parent do
            render :update do |page|
              page.visual_effect(:slide_up, 'photo_form')
              page.replace_html 'gallery_photos_field', :partial =>  '/admin/galleries/photos'
            end
          end
        end
      else
        format.html do
          responds_to_parent do
            render :update do |page|
              page.replace_html 'photo_form', :partial =>  'new'
            end
          end
        end
      end      
    end
  end
  
  def destroy
    @gallery = Gallery.find(params[:gallery_id])
    @photo = Photo.find(params[:id])
    
    @photo.destroy
    respond_to do |format|
      format.js { render :partial => '/admin/galleries/photos' }
    end
  end
  
end
