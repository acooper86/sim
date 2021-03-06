class PostsController < ApplicationController
  before_filter :correct_user
  	
  layout "logged"
  
  def new
  	@title = "Create a New Post"
  	@user = User.find(params[:user_id])
  	@blog = @user.blog
  	@post = @blog.post.new
  	@post.ptype = params[:type]
  	3.times { @post.tag.build}
  	@post.category.new
  end

  def create
  	@user = User.find(params[:user_id])
  	@blog = @user.blog
  	@post = @blog.post.new(params[:post])
  	
  	if @post.save
  		flash[:success]="Post Successfully Created"
  		if params[:tag]
  	      @post.post_tags.new(:tag_id => params[:tag]).save
  	    end
  	    
  	    if params[:category]
  	      @post.post_categories.new(:category_id => params[:category]).save unless params[:category].blank?
  	    end
  		
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
  		@post.post_tags.destroy_all
  		
  		if params[:tag]	  
  		  params[:tag].each do |t|
  		    tag = @post.post_tags.create("tag_id"=>t)
  		  end
  		end
  		
  		unless params[:new_tag].empty?
  		  params[:new_tag].each do |nt|
  			unless nt.empty?
  			  tag = @post.tag.new("tag"=> nt) 
  			  tag.save
  			  pt = @post.post_tags.create("tag_id" => tag.id)
  		    end
  		  end
  		end
  		
  		unless params[:category].empty?
  		  @post.post_categories.first.update_attribute('category_id', params[:category])
  		end
  		
  		@post.post_categories.destroy_all
  		if params[:new_category]	  
  		  cat = @post.category.new
  		  cat.name = params[:new_category]
  		  cat.save
  		  @post.post_categories.create("category_id"=> cat.id)
  		end
  		
  		flash[:success]="Post Successfully Updated"
  		redirect_to user_blogs_posts_path(@user)
  	else
  		@title = "Error Updating Post"
  		render 'edit'
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
  	@posts = @blog.post.paginate(:page=>params[:page], :per_page => 4).order('created_at desc')
  end
  
  private
  	def correct_user
  		@client = User.find(params[:user_id])
  		redirect_to(root_path) unless current_user?(@client)
  	end
end
