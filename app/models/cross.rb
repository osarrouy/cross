class Cross < ActiveRecord::Base
  
  include Singleton
  
  set_table_name "cross"
  
  def self.instance
    self.find(:first) || Cross.new
  end
  
end