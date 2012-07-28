class NewsMailController < ApplicationController
  layout "logged"
  
  def index
    @title = "View All Campaign Mail"
    @user = User.find(params[:user_id])
    @nm = @user.news_message.paginate(:page=>params[:page], :per_page => 15).order('created_at DESC')
  end
  
  def new
    @title = "New Campaign Message"
    @user = User.find(params[:user_id])
    @nm = @user.news_message.new
  end
  
  def create
    @user = User.find(params[:user_id])
    nm = @user.news_message.new(params[:news_message])

    if nm.save
    	if nm.send_message(@user)
    	  flash[:success] = "Campaign Was Sent"
    	  redirect_to mail_user_path(@user)
    	else
    	  flash[:notice] = "The campaign was saved but not sent."
    	  redirect_to mail_user_path(@user)
    	end
    else
    	@title = "There was a problem creating your campaign."
    	render 'new'
    end
  end
end
