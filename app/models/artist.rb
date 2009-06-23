class Artist < ActiveRecord::Base
  
  has_many :galleries, :dependent => :destroy
  
end
