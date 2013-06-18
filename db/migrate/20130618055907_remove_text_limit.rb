class RemoveTextLimit < ActiveRecord::Migration
  def change
  	change_column :posts, :content_markdown, :text, :limit => nil
  	change_column :posts, :content_html, :text, :limit => nil
  	change_column :posts, :title, :text, :limit => nil
  end
end
