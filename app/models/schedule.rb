class Schedule < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible(:schedule, :timezone, :padding, :online, :contact_only, :user_email, :contact_email, :confirmation, :send_reminder, :reminder, :cap_name, :cap_email, :cap_phone, :cap_address, :outcall, :office, :office_location, :cancellation, :cancellation_time, :cancellation_policy)

  serialize :schedule, Hash
end
