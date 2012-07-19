class PostsController < ApplicationController
  before_filter :correct_user
  	
  layout "logged"
  
  def new
  	@title = "Create a New Post"
  	@user = User.find(params[:user_id])
  	@blog = @user.blog
  	@post = @blog.post.new
  end

  def create
  	@user = User.find(params[:user_id])
  	@blog = @user.blog
  	@post = @blog.post.new(params[:post])
  	
  	if @post.save
  		flash[:success]="Post Successfully Created"
  		redirect_to user_blogs_posts_path(@user)
  	else
  		@title = "Error Creating Post"
  		render 'new'
  	end
  end

  def edit
	@title = "Edit your Post"
	@user = User.find(params[:user_id])
  	@blog = @user.blog
  	@post = Post.find(params[:id])
  end

  def update
  	@user = User.find(params[:user_id])
  	@blog = @user.blog
  	@post = Post.find(params[:id])
  	
  	if @post.update_attributes(params[:post])
  		flash[:success]="Post Successfully Updated"
  		redirect_to user_blogs_posts_path(@user)
  	else
  		@title = "Error Updating Post"
  		render 'new'
  	end
  end

  def show
	@title = "View Post"
	@user = User.find(params[:user_id])
  	@blog = @user.blog
  	@post = Post.find(params[:id])
  end

  def destroy
  	@user = User.find(params[:user_id])
  	@post= Post.find(params[:id])
  	if @post.destroy
  		flash[:success] = "Posts and Comments Deleted"
  		redirect_to user_blogs_path(@user)
  	else
  		@title = "Unable to Destroy"
  		render 'edit'
  	end
  end

  def index
	@title = "View all Posts"
	@user = User.find(params[:user_id])
  	@blog = @user.blog
  	@posts = @blog.post.paginate(:page=>params[:page], :per_page => 10)
  end
  
  private
  	def correct_user
  		@client = User.find(params[:user_id])
  		redirect_to(root_path) unless current_user?(@client)
  	end
end
