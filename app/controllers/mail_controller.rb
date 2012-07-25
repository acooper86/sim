class MailController < ApplicationController
  
  layout "logged"
  
  def index
    @title = "View All Mail"
    @user = User.find(params[:user_id])
    @dm = @user.contact_message
  end
  
  def new
    @title = "New Direct Message"
    @user = User.find(params[:user_id])
    @dm = @user.contact_message.new
  end
  
  def create
    @user = User.find(params[:user_id])
    dm = @user.contact_message.new(params[:contact_message])
    dm.recipients = dm.recipients.split(", ")
    if params[:contacts]
    	params[:contacts].each do |email|
    	  dm.recipients << email
    	end
    end
    
    if dm.save
    	if dm.send_message(@user)
    	  flash[:success] = "Message Sent"
    	  redirect_to user_mail_index_path
    	else
    	  flash[:notice] = "The message was saved but not sent."
    	  redirect_to user_mail_index_path
    	end
    else
    	@title = "There was a problem creating your email."
    	render 'new'
    end
  end

end
