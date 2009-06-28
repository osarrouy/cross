class CrossController < ApplicationController
  
  layout 'public'
  
  def index
    @cross = Cross.instance
    
    respond_to do |format|
      format.html
    end
  end
  
end