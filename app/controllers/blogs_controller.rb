class BlogsController < ApplicationController
  before_filter :correct_user
  	
  layout "logged"
   
  def new
  	@title = "Create your own Blog"
  	@user = User.find(params[:user_id])
  	@blog = @user.build_blog
  end

  def create
  	@user = User.find(params[:user_id])
  	@blog = @user.build_blog(params[:blog])
  	
  	if @blog.save
  		flash[:success]="Blog Successfully Created"
  		redirect_to user_blogs_path
  	else
  		@title = "Error Creating Blog"
  		render 'new'
  	end
  end

  def edit
  	@title = "Edit your blog Settings"
  	@user = User.find(params[:user_id])
  	@blog = @user.blog
  end

  def update
  	@user = User.find(params[:user_id])
  	@blog = @user.blog
  	
  	if @blog.update_attributes(params[:blog])
  		flash[:success]="Blog Successfully Updated"
  		redirect_to user_blogs_path
  	else
  		@title = "Error Creating Blog"
  		render 'new'
  	end
  end

  def show
  	@title = "Your Blog"
  	@user = User.find(params[:user_id])
  	@blog = @user.blog
  	@posts = Post.order("created_at desc").limit(2)
  end
  
   def destroy
  	@user = User.find(params[:user_id])
  	@blog= @user.blog
  	@blog.destroy
  	flash[:success] = "Blog and all posts Deleted"
  	redirect_to dashboard_path
  end
  
  private
  	def correct_user
  		@client = User.find(params[:user_id])
  		redirect_to(root_path) unless current_user?(@client)
  	end
end

