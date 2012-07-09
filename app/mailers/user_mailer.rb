class UserMailer < ActionMailer::Base
  default from: "admin@simplissage.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
  	@user = user
  	mail :to => user.email, :subject => "Password Reset"
  end
  
  def activate(user)
  	@user = user
  	mail :to => user.email, :subject => "Account Activation Required"
  end
  
end
