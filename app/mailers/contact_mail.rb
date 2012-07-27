class ContactMail < ActionMailer::Base
  helper :mail
  def direct_mail(user, contact_message, to, contact)
  	@user = user
  	@contact = contact
  	@contact_message = contact_message
  	@theme = @contact_message.theme
  	mail(:to => to, :subject => contact_message.subject, :from => "no-reply" << @user.website.domain, :reply_to => @user.email)
  end
end
