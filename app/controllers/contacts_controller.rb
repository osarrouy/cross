class ContactsController < ApplicationController
  
  layout 'public'
  
  def index
    @artists = Artist.find(:all, :order => 'last_name ASC')
    
    respond_to do |format|
      format.html
    end
  end
  
end