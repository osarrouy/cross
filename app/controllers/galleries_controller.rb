class GalleriesController < ApplicationController
  
  layout 'public'

  def show
    @gallery = Gallery.find(params[:id])
    
    respond_to do |format|
      format.json { render :json => @gallery.to_json }
      format.js
    end
  end
  
  def minis
    @gallery = Gallery.find(params[:id])
    
    respond_to do |format|
      format.js
    end
  end

end