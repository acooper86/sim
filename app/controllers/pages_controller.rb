class PagesController < ApplicationController
	layout "logged"
	layout "page_edit", :only => "edit"
	
	def new
		@title = "Create a New Page"
		@user = User.find(params[:user_id])
		@website = @user.website
		@page = @website.page.build
	end

	def create
		@user = User.find(params[:user_id])
		@website = @user.website
		@page = @website.page.build
		@page.ptitle = params[:page][:ptitle]
		@page.ptype = params[:page][:ptype]
		@page.child = params[:page][:child]
		@page.indexed = params[:page][:indexed]
		if @page.save
			flash[:success] = "Your Page was successfully created."
			update_order(@website,@page.id)
			redirect_to edit_user_websites_path
		else
			@title = "Create a New Page"
			render 'new'
		end
	end
	
	def edit
		@title = "Edit Your Page"
		@user = User.find(params[:user_id])
		@website = @user.website
		@page = Page.find(params[:id])
	end
	
	def update
		@user = User.find(params[:user_id])
		@website = @user.website
		@page = Page.find(params[:id])
		
		if @page.update_attributes(params[:page])
			flash[:success] = "Your page was successfully updated."
			redirect_to edit_user_websites_path
		else
			@title = "Update Invalid"
			redirect_to edit_user_websites_path
		end
	end
	
	def show
		@user = User.find(params[:user_id])
		@website = @user.website
		@page = Page.find(params[:id])
		render :layout => false
	end
	
	def destroy
		@page = Page.find(params[:id])
		@user = User.find(params[:user_id])
		@website = @user.website
		
		if @page.destroy
			@website.updateOrder(@page.id)
			flash[:success] = "Your page was perminently deleted"
			redirect_to edit_user_websites_path
		else
			@title = "Destroy Failed"
			flash[:notice] = "If you continue having problems please submitt a support request."
			redirect_to edit_user_websites_path
		end
	end
	private
		def update_order(website,id)
			if website.order.blank? 
				@newOrder = Array(id)
				website.update_attribute(:order, @newOrder)
			else
				@newOrder = website.order << id
				website.update_attribute(:order, @newOrder)
			end
		end	
end
