class NotificationMailer < ActionMailer::Base

  default from: "admin@simplissage.com"
  default :to => "fluke.a@gmail.com"
  
  def new_message(message)
  	@message = message
  	mail(:subject => "Simplissage||#{message.subject}")
  end
  
end
