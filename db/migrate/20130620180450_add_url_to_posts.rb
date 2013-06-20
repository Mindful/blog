class AddUrlToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :url, :string, :nil => false
    add_index :posts, :url, :unique => true

    #to generate the URLs for all existing users:
    Post.initialize_urls
  end
end
