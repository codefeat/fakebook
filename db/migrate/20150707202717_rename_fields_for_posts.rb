class RenameFieldsForPosts < ActiveRecord::Migration
  def change
  	remove_column :posts, :contents, :string
  	add_column :posts, :content, :string
  end
end
