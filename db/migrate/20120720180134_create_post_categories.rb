class CreatePostCategories < ActiveRecord::Migration
  def change
    create_table :post_categories do |t|
      t.references :post
      t.references :category
    end
    add_index :post_categories, :post_id
    add_index :post_categories, :category_id
  end
end
