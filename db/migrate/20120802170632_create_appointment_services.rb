class CreateAppointmentServices < ActiveRecord::Migration
  def change
    create_table :appointment_services do |t|
      t.references :appointment
      t.references :service

      t.timestamps
    end
    add_index :appointment_services, :appointment_id
    add_index :appointment_services, :service_id
  end
end
