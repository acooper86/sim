class Contact < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible(:first_name, :last_name, :email,:secondary_email,:phone,:address_l1,:address_l2,:city,:state,:zip,:business,:birth_date, :ctype, :email_list,:opt_in,:created_from) 
end
