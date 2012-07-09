class WebsitesController < ApplicationController
	
  	before_filter :correct_user, :only => [:edit,:update, :publish]
  	before_filter :admin_user, :only => :destroy
  	
	layout "logged"
  	
	def new
		@title = "Create a New Website"
		@user = User.find(params[:user_id])
		@website = @user.build_website
	end
	
	def create
		@user = User.find(params[:user_id])
		@website = @user.build_website
		@website.domain = params[:website][:domain]
		@website.title = params[:website][:title]
		@website.motto = params[:website][:motto]
		@website.theme = params[:website][:theme]
		if @website.save
			flash[:success] = "Your website was successfully created."
			redirect_to edit_user_websites_path
		else
			@title = "Create a New Website"
			render 'new'
		end
	end
	
	def edit
		@title = "Edit your website settings"
		@user = User.find(params[:user_id])
		@website = @user.website
	end
	
	def update
		@user = User.find(params[:user_id])
		@website = @user.website
		
		if @website.update_attributes(params[:website])
			flash[:success] = "Your website was successfully updated."
			redirect_to edit_user_websites_path
		else
			@title = "Update Invalid"
			render 'edit'
		end
	end
	
	def publish
		@user = User.find(params[:user_id])
		@website = @user.website
		
		if @website.publish_site
			flash[:success] = "Your website was successfully published."
			redirect_to edit_user_websites_path
		else
			@title = "Publication Not Successful"
			render 'edit'
		end
	end
	
	private
  	def authenticate
  		deny_access unless signed_in?
  	end
  	
  	def correct_user
  		@client = User.find(params[:user_id])
  		redirect_to(root_path) unless current_user?(@client)
  	end
  	
  	def admin_user
  		redirect_to(root_path) unless current_user.admin?
  	end
	
end
