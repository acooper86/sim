class CreateNewsMessages < ActiveRecord::Migration
   def change
    create_table :news_messages do |t|
      t.references :user
      t.string :title
      t.string :message
      t.string :theme
      t.string :attachements
      t.boolean :business
      t.boolean :subscribers
      t.boolean :clients

      t.timestamps
    end
    add_index :news_messages, :user_id
  end
end