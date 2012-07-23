class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :blog
      t.string :title
      t.text :content
      t.string :ptype
      t.string :tags
      t.string :categories
	  t.string :image
	  t.string :block_quote
	  t.string :q_author
	  t.string :href
	  t.string :link_text
	  t.string :video
	  
      t.timestamps
    end
    add_index :posts, :blog_id
  end
end
