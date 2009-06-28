class Photo < ActiveRecord::Base
  
  belongs_to :gallery
  
  has_attached_file :image, :styles => { :medium => "250x250>", :thumb => "x90>", :mini => "60x60#" },
    :url => "/photos/:id/:style/:basename.:extension",
    :path => ":rails_root/public/photos/:id/:style/:basename.:extension"

  # has_attachment :content_type => :image, :storage => :file_system, :max_size => 10.megabytes,
  #   :resize_to => '800x650>', :thumbnails => { :thumb => 'x90>', :medium => '250x250>' }
  # 
  # validates_as_attachment
  # 
  # validates_presence_of :filename, :message => 'Le fichier attaché ne doit pas être vide'
  
  validates_attachment_presence :image
   
  def add_size_error(options)
    return unless filename
    msg = "Le fichier attaché doit avoir une taille comprise entre 1 octet et 10 megaoctets"
    errors.add_to_base(msg)
  end
                        
  def add_content_type_error(options)
    return unless filename
    msg = "Le fichier attaché doit être une image"
    errors.add_to_base(msg)  
  end
  
end
