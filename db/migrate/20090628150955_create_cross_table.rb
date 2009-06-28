class CreateCrossTable < ActiveRecord::Migration
  def self.up
    create_table :cross do |t|
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :description
  end
end
