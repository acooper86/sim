class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.references :user
      t.references :contact
      t.datetime :start
      t.datetime :finish
      t.string :duration
      t.string :location
      t.string :status

      t.timestamps
    end
    add_index :appointments, :user_id
    add_index :appointments, :contact_id
  end
end
