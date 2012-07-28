class NewsMessage < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible(:title, :message, :theme, :attachements, :clients, :subscribers, :business)

  def send_message(user)
  	recipients = []
  	if self.clients
  		recipients = user.contact.where(:email_list => true, :ctype => 'client')
  	end
  	if self.subscribers
  		recipients += user.contact.where(:email_list => true, :ctype => 'subscriber')
  	end
  	if self.business
  		recipients += user.contact.where(:email_list => true, :ctype => 'business')
  	end
  	
    recipients.each do |contact|
       ContactMail.news_mail(user, self, contact).deliver
    end
  end

end
