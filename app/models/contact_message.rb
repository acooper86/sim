class ContactMessage < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible(:subject, :message, :theme, :recipients, :attachements)
  
  serialize :recipients, Array

  def send_message(user)
  	self.recipients.each do |rec|
  	  unless rec.include?("@")
        contact = Contact.find(rec)
        to = "\"#{contact.first_name} #{contact.last_name}\" <#{contact.email}>"
      else
        to = rec
        contact = user.contact.new('email' => rec)
      end
     ContactMail.direct_mail(user, self, to, contact).deliver
    end
  end

end
