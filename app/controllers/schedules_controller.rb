class SchedulesController < ApplicationController
  
  before_filter :correct_user
  before_filter :admin_user, :only => :destroy
  	
  layout "logged"
  	
  def new
    @title = "Create Your Schedule"
		@user = User.find(params[:user_id])
		@schedule = @user.build_schedule
	end
	
	def create
		@user = User.find(params[:user_id])
		@schedule = @user.build_schedule(params[:schedule])
		@schedule.schedule = params[:schedule_times]
		if @schedule.save
			flash[:success] = "Your schedule settings were successfully created."
			redirect_to edit_user_schedules_path
		else
			@title = "Create a New Website"
			render 'new'
		end
	end
	
	def edit
		@title = "Edit your schedule settings"
		@user = User.find(params[:user_id])
		@schedule = @user.schedule
	end
	
	def update
		@user = User.find(params[:user_id])
		@schedule = @user.schedule
		
		if @schedule.update_attributes(params[:schedule])
	      if @schedule.update_attributes(:schedule, params[:schedule_times])
			flash[:success] = "Your schedule was successfully updated."
			redirect_to user_schedules_path
		  elsif
		    flash[:notice] = "Your settings were updated, but there was a problem saving your times. Please contact support. We apologize for the inconvenience."
		    redirect_to user_schedules_path
		  end
		else
			@title = "Update Invalid, please contact support if this issue persists."
			render 'edit'
		end
	end
	
	def show
	  @title = "Your schedule"
	  @user = User.find(params[:user_id])
	  @schedule = @user.schedule
	end
	
	def destroy
  	  @user = User.find(params[:user_id])
  	  @schedule = @user.schedule
  	  
  	  if @schedule.destroy
  		flash[:success] = "Schedule has been reset."
  		redirect_to new_user_schedules_path
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
  	
  	def admin_user
  		redirect_to(root_path) unless current_user.admin?
  	end
	
end
