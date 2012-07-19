class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.references :user
      t.string :title
      t.integer :per_page
      t.string :allow_comments
      t.integer :per_comments
      t.boolean :recent
      t.boolean :tag_cloud
      t.boolean :categories
      t.boolean :archive

      t.timestamps
    end
    add_index :blogs, :user_id
  end
end
