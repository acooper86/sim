class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index,:show,:edit, :update, :dashboard, :support]
  before_filter :correct_user, :only => [:edit,:update]
  before_filter :admin_user, :only => :destroy
  
  layout "logged", :except => :new
  
  def new
  	@title = "Sign up"
  	@user = User.new
  end
  
  def create
  	@user = User.new(params[:user])
  	if @user.save
  		@user.send_activation
  		flash[:success] = "#{@user.first_name}, welcome to Simplissage! Please verify your email address to login."
  		redirect_to root_path
  	else
  		@title= "Sign up"
  		render 'new'
  	end
  end
  
  def index
  	@title = "All users"
  	@users = User.all
  end
  
  def show
  	@user = User.find(params[:id])
  	@title = User.name
  end
  
  def edit
  	@user = User.find(params[:id])
  	@title = "Edit Profile"
  end
  
  def update
  	@user = User.find(params[:id])
  	if @user.update_attributes(params[:user])
  		flash[:success] = "Profile updated."
  		cookies.permanent.signed[:remember_token]=[@user.id, @user.salt]
  		redirect_to @user
  	else
  		@title = "Edit user"
  		render 'edit'
  	end
  end
  
  def destroy
  	User.find(params[:id]).destroy
  	flash[:success] = "User destroyed"
  	redirect_to users_path
  end
  
  def dashboard
  	@title = "Dashboard"
  	@user = current_user
  	@website = @user.website
  end
  
  def support
  	@title = "Support"
  end
  
  def activate
  	@user = User.find_by_activated(params[:id])
  	if @user.set_activation
  		flash[:success] = "Email activated, you are now ready to log in."
  		redirect_to new_session_path
  	else
  		flash[:notice] = "There was an error activating your email, please contact the site administrator."
  		redirect_to new_session_path
  	end
  end
  
  def mail
    @title = "View All Mail"
    @user = User.find(params[:id])
    @dm = @user.contact_message.paginate(:page=>params[:page], :per_page => 15).order('created_at DESC')
    @nm = @user.news_message.paginate(:page=>params[:page], :per_page => 15).order('created_at DESC')
  end
  
  private
  	def authenticate
  		deny_access unless signed_in?
  	end
  	
  	def correct_user
  		@user = User.find(params[:id])
  		redirect_to(root_path) unless current_user?(@user)
  	end
  	
  	def admin_user
  		redirect_to(root_path) unless current_user.admin?
  	end
end
