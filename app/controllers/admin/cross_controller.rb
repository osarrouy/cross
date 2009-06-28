class Admin::CrossController < ApplicationController
  
  layout 'admin'
  
  def index
    @cross = Cross.instance
    
    respond_to do |format|
      format.html
    end
  end
  
  def edit
    @cross = Cross.instance
    
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @cross = Cross.instance

    respond_to do |format|
      if @cross.update_attributes(params[:cross])
        format.html { redirect_to :action  => "index" }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
end