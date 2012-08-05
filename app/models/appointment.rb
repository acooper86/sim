class Appointment < ActiveRecord::Base
  after_save :update_end_time
  
  belongs_to :user
  belongs_to :contact
  
  has_many :appointment_service
  has_many :service, :through => :appointment_service
  
  attr_accessible(:date,:start,:finish,:duration,:location,:status,:contact_id)
  
  protected
    def update_end_time
      self.update_column( :finish, self.start + self.duration.to_i.minutes)
    end
end
