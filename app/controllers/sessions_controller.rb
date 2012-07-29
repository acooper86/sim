class SessionsController < ApplicationController
  def new
  	@title = "Sign in"
  end
  
  def create
  	user = User.authenticate(params[:session][:email], params[:session][:password])
  	
  	if user.nil?
  		flash.now[:error] = "Invalid email/password combination."
  		@title = "Sign in"
	  	render 'new'
	else
		if user.activated == "t"
			sign_in(user,params[:session][:permanent])
			redirect_back_or dashboard_path
		else
			flash.now[:error] = "The Account you are trying to access has not been activated. Please check any spam filters for lost emails."
  			@title = "Sign in"
		  	render 'new'
		end
	end
  end
  
  def destroy
  	sign_out
  	redirect_to root_path
  end
end
