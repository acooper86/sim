class ImagesController < ApplicationController
	before_filter :correct_user
  	
	layout "logged"
  	
	def new
		@title = "Create a New Image"
		@user = User.find(params[:user_id])
		@image = @user.image.new
	end
	
	def create
		@user = User.find(params[:user_id])
		@image = @user.image.new(params[:image])
		if @image.save
			flash[:success] = "Your image was successfully created."
			redirect_to user_images_path
		else
			@title = "Create a New Image"
			render 'new'
		end
	end
	
	def edit
		@title = "Edit your Image settings"
		@user = User.find(params[:user_id])
		@image = Image.find(params[:id])
	end
	
	def update
		@user = User.find(params[:user_id])
		@image = Image.find(params[:id])
		
		if params[:profile]
			@user.image.each do |i|
				i.update_attribute('profile',false)
			end
			
			if @image.update_attribute('profile',true)
				flash[:success] = "Your image was successfully marked as a Profile Image."
				redirect_to user_image_path(@user,@image)
			end
		elsif params[:logo]
			@user.image.each do |i|
				i.update_attribute('logo',false)
			end
			if @image.update_attribute('logo',true)
				flash[:success] = "Your image was successfully marked as a Logo Image."
				redirect_to user_image_path(@user,@image)
			end
		elsif @image.update_attributes(params[:image])
			flash[:success] = "Your image was successfully updated."
			redirect_to user_images_path
		else
			@title = "Update Invalid"
			render 'edit'
		end
	end
	
	def show
		@title = "View your Image"
		@user = User.find(params[:user_id])
		@image = Image.find(params[:id])
	end
	
	def index
		@title = "View all your Images"
		@user = User.find(params[:user_id])
		@images = @user.image
	end
	
	def destroy
		@user = User.find(params[:user_id])
  		@image= Image.find(params[:id])
  		@image.remove_image!
  		@image.destroy
  		flash[:success] = "Image destroyed"
  		redirect_to user_images_path(@user)
  	end
	
	private
  	def correct_user
  		@client = User.find(params[:user_id])
  		redirect_to(root_path) unless current_user?(@client)
  	end
end
