class PhotosController < ApplicationController
  
  layout 'public'
  
  def show
    @photo = Photo.find(params[:id])
    
    respond_to do |format|
      format.js
    end
    
  end
  
end