class CreateContactMessages < ActiveRecord::Migration
  def change
    create_table :contact_messages do |t|
      t.references :user
      t.string :subject
      t.string :message
      t.string :theme
      t.string :recipients
      t.string :attachements

      t.timestamps
    end
    add_index :contact_messages, :user_id
  end
end
