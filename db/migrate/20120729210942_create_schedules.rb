class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :user
      t.string :schedule
      t.integer :padding
      t.boolean :online
      t.boolean :contact_only
      t.boolean :user_email
      t.boolean :contact_email
      t.string :confirmation
      t.integer :send_reminder
      t.string :reminder
      t.boolean :cap_name
      t.boolean :cap_email
      t.boolean :cap_phone
      t.boolean :cap_address
      t.boolean :outcall
      t.boolean :office
      t.string :office_location
      t.boolean :cancellation
      t.integer :cancellation_time
      t.string :cancellation_policy

      t.timestamps
    end
    add_index :schedules, :user_id
  end
end
