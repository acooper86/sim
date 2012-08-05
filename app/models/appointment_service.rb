class AppointmentService < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :service
end
