class ContactMail < ActionMailer::Base
  helper :mail
  def direct_mail(user, contact_message, to, contact)
  	@user = user
  	@contact = contact
  	@contact_message = contact_message
  	@theme = @contact_message.theme
  	mail(:to => to, :subject => contact_message.subject, :from => "no-reply" << @user.website.domain, :reply_to => @user.email)
  end
  
  def news_mail(user, contact_message, contact)
  	@user = user
  	@contact = contact
  	@contact_message = contact_message
  	@theme = @contact_message.theme
  	
  	to = contact.email
  	mail(:to => to, :subject => contact_message.title, :from => "no-reply" << @user.website.domain, :reply_to => @user.email)
  end
end
