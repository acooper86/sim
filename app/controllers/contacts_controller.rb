class ContactsController < ApplicationController
  before_filter :correct_user
  	
  layout "logged"
  
  def new
  	@title="Create a new Contact"
  	@user = User.find(params[:user_id])
  	@contact = @user.contact.new
  end

  def create
  	@user = User.find(params[:user_id])
  	@contact = @user.contact.new(params[:contact])
  	if params[:contact][:birth_date]
  		@contact.birth_date = Date.new(params[:contact][:birth_date])
  	end
  	
  	if @contact.save
		flash[:success] = "Your contact was successfully created."
		redirect_to user_contacts_path
	else
		@title = "Create a New Image"
		render 'new'
	end
  end
  
  def edit
  	@title="Edit your Contact"
  	@user = User.find(params[:user_id])
  	@contact = Contact.find(params[:id])
  end
  
  def update
  	@user = User.find(params[:user_id])
  	@contact = Contact.find(params[:id])
  	
  	if @contact.update_attributes(params[:contact])
		flash[:success] = "Your contact was successfully updated."
		redirect_to user_contacts_path
	else
		@title = "Update Invalid"
		render 'edit'
	end
  end
  
  def index
  	@title="View all your Contacts"
  	@user = User.find(params[:user_id])
  	@contacts = @user.contact
  end

  def show
  	@title="View your Contact"
  	@user = User.find(params[:user_id])
  	@contact = Contact.find(params[:id])
  end

  def destroy
  	@user = User.find(params[:user_id])
  	@contact= Contact.find(params[:id])
  	@contact.destroy
  	flash[:success] = "Contact Removed"
  	redirect_to user_contacts_path(@user)
  end
  
  private
  	def correct_user
  		@client = User.find(params[:user_id])
  		redirect_to(root_path) unless current_user?(@client)
  	end
end
