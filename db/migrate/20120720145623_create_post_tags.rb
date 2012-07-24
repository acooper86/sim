class CreatePostTags < ActiveRecord::Migration
  def change
    create_table :post_tags do |t|
      t.references :tag
      t.references :post

      t.timestamps
    end
    add_index :post_tags, :tag_id
    add_index :post_tags, :post_id
  end
end
