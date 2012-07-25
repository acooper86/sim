class ContactMail < ActionMailer::Base
  def direct_mail(user, contact_message, to, contact)
  	@user = user
  	@contact = contact
  	@contact_message = contact_message
  	mail(:to => to, :subject => contact_message.subject, :from => "no-reply" << @user.website.domain, :reply_to => @user.email)
  end
end
