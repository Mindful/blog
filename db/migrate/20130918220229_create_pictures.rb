class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name

      t.timestamps
    end
    add_index :pictures, :name, :unique => true
  end
end
