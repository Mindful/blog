class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.decimal :latitude, :precision => 10, :scale => 6
      t.decimal :longitude , :precision => 11, :scale => 6

      t.timestamps
    end
  end
end
