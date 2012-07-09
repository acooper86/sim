class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :website_id
      t.boolean :indexed, :default => true
      t.text :content
      t.string :type, :default => "Normal"
      t.boolean :child, :default => false
      t.string :ptitle

      t.timestamps
    end
  end
end
