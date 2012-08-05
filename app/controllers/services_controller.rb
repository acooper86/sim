class ServicesController < ApplicationController
  
  before_filter :correct_user
  	
  layout "logged"
  	
  def new
    @title = "Create A New Service"
	@user = User.find(params[:user_id])
	@service = @user.service.new
  end
	
  def create
    @user = User.find(params[:user_id])
	@service = @user.service.new(params[:service])
    
    if params[:available]
      @service.available = @service.create_available_hash(params[:available])
    end
    
	if @service.save
	  if params[:prereq]
	    params[:prereq].each do |p|
	      @service.prerequisite_relationship.new(:main_id => p).save
	    end
	
	    flash[:success] = "Your service was successfully created with prerequisites."
	    redirect_to user_services_path
	  else
	  
	  flash[:success] = "Your service was successfully created."
	  redirect_to user_services_path
	  end
	else
	  @title = "Create a New Service"
	  render 'new'
	end
  end
	
  def edit
	@title = "Edit your service settings"
	@user = User.find(params[:user_id])
	@service = Service.find(params[:id])
  end
	
  def update
    @user = User.find(params[:user_id])
	@service = Service.find(params[:id])
	
	if params[:available]
      @service.update_attribute(:available, @service.create_available_hash(params[:available]))
    end
	
	if @service.update_attributes(params[:service])
	  @service.prerequisite_relationship.destroy_all
	  
	  if params[:prereq]  
	    params[:prereq].each do |p|
	      @service.prerequisite_relationship.new(:main_id => p).save
	    end
	
	    flash[:success] = "Your service was successfully updated with prerequisites."
	    redirect_to user_services_path
	  else
	  
	    flash[:success] = "Your service was successfully updated."
	    redirect_to user_services_path
	  end
	else
	  @title = "Update Invalid, please contact support if this issue persists."
	  render 'edit'
	end
  end
	
  def show
    @title = "Service"
	@user = User.find(params[:user_id])
	@service = Service.find(params[:id])
  end
  
  def index
    @title = "Available Services"
	@user = User.find(params[:user_id])
	@services = @user.service
  end
	
  def destroy
    @user = User.find(params[:user_id])
    @service = Service.find(params[:id])
  	  
  	if @service.destroy
  	  flash[:success] = "Service Deleted."
  	  redirect_to user_services_path
  	else
  	  @title = "Unable to Destroy"
  	  render 'edit'
  	end
  end
	
  private
    def correct_user
  	  @client = User.find(params[:user_id])
  	  redirect_to(root_path) unless current_user?(@client)
  	end
end
