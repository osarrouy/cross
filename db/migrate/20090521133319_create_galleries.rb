class CreateGalleries < ActiveRecord::Migration
  def self.up
    create_table :galleries do |t|
      t.integer :artist_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :galleries
  end
end
