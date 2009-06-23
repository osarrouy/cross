class Admin::ArtistsController < ApplicationController
  
  layout 'admin'
  
  def index
    if params[:search].blank?
      @artists = Artist.find(:all)
    else
      @artists = Artist.find(:all, :conditions => [ "first_name LIKE ? OR last_name LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%" ])
    end
    
    respond_to do |format|
      format.html
      format.js
    end
    
  end

end
