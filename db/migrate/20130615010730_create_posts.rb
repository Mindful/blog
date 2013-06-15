class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content_markdown
      t.string :content_html

      t.timestamps
    end
  end
end
