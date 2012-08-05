class Contact < ActiveRecord::Base
  belongs_to :user
  
  has_many :appointment
  
  before_create :opt_in_date
  
  attr_accessible(:first_name, :last_name, :email,:secondary_email,:phone,:address_l1,:address_l2,:city,:state,:zip,:business,:birth_date, :ctype, :email_list,:opt_in,:created_from) 

  private
  	def opt_in_date
  		if self.email_list == true
  			self.opt_in = Time.now
  		end
  	end
end
