class SwitchToPaperclip < ActiveRecord::Migration
  def self.up
    drop_table "photos"
    create_table "photos", :force => true do |t|
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at 
    end
  end

  def self.down
    drop_table "photos"
    create_table "photos", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "gallery_id"
      t.integer  "parent_id"
      t.string   "content_type"
      t.string   "filename"
      t.string   "thumbnail"
      t.integer  "size"
      t.integer  "width"
      t.integer  "height"
    end
  end
end
