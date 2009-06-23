class Gallery < ActiveRecord::Base
  
  belongs_to  :artist
  has_many    :photos, :dependent => :destroy
  acts_as_videoclub
  
  validates_presence_of :artist, :message => "La galerie doit être rattachée à un artiste"
  
end
