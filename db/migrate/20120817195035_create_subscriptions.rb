class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user
      t.integer :profile
      t.string :status
      t.float :cost
      t.string :level

      t.timestamps
    end
    add_index :subscriptions, :user_id
  end
end
