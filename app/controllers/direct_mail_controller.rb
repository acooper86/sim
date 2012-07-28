class DirectMailController < ApplicationController
  layout "logged"
  
  def index
    @title = "View All Direct Mail"
    @user = User.find(params[:user_id])
    @dm = @user.contact_message.paginate(:page=>params[:page], :per_page => 15).order('created_at DESC')
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
    	  redirect_to mail_user_path(@user)
    	else
    	  flash[:notice] = "The message was saved but not sent."
    	  redirect_to mail_user_path(@user)
    	end
    else
    	@title = "There was a problem creating your email."
    	render 'new'
    end
  end
end
