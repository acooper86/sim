class DropTagCategoriesFromPost < ActiveRecord::Migration
  def up
  	remove_column :posts, :tags
  	remove_column :posts, :categories
  end

  def down
  	add_column :posts, :tags, :string
  	add_column :posts, :categories, :string
  end
end
