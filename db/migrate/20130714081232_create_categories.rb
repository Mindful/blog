class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.references :tag, index: true

      t.timestamps
    end
  end
end
