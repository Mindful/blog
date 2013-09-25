class UpdateMigrationsAndConnectToPosts < ActiveRecord::Migration
  def change
  	#locations ---
  	add_column :locations, :post_id, :integer
  	add_index :locations, :post_id
  	add_column :locations, :image, :string
  end
end
