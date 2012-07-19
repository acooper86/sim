class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :blog
      t.string :title
      t.text :content
      t.string :ptype
      t.string :tags
      t.string :categories

      t.timestamps
    end
    add_index :posts, :blog_id
  end
end
