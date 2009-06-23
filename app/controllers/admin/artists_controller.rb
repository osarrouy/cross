class Admin::ArtistsController < ApplicationController
  
  layout 'admin'
  
  def index
    @artists = Artist.find(:all, :order => 'last_name')

    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new
    @artist = Artist.new
    
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @artist = Artist.new(params[:artist])

    respond_to do |format|
      if @artist.save
        format.html { redirect_to admin_artists_path }
      else
        format.html { render :action => 'new' }
      end
    end
  end
  
  def edit
    @artist = Artist.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @artist = Artist.find(params[:id])

    respond_to do |format|
      if @artist.update_attributes(params[:artist])
        format.html { redirect_to admin_artists_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to admin_artists_path }
    end
  end

end
