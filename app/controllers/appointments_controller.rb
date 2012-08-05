class AppointmentsController < ApplicationController
  before_filter :correct_user
  
  before_filter :time_zone
  
  layout "logged"

  def new
    @title = "Create a new appointment."
    @user = User.find(params[:user_id])
    @appointment = @user.appointment.new
  end
  
  def create
    @user = User.find(params[:user_id])
  	@appointment = @user.appointment.new(params[:appointment])
  	
  	if @appointment.save
  		if params[:service]
  		  params[:service].each do |s|
  		    @appointment.appointment_service.new(:service_id => s).save
  		  end
  		  
  		  flash[:success]="Appointment created successfully."
  		  redirect_to user_schedules_path
  		else
  		  flash[:notice]="Appointment created, but no services were attached."
  		  redirect_to user_schedules_path
  		end
  	else
  		@title = "Error Creating Post"
  		render 'new'
  	end
  end
  
  def edit
    @title = "Create a new appointment."
    @user = User.find(params[:user_id])
    @appointment = Appointment.find(params[:id])
  end
  
  def update
    @user = User.find(params[:user_id])
  	@appointment = Appointment.find(params[:id])
  	
  	if @appointment.update_attributes(params[:appointment])
  		@appointment.appointment_service.destroy_all
  		
  		if params[:service]	  
  		  params[:service].each do |s|
  		    @appointment.appointment_service.create("service_id"=>s)
  		  end
  		end
  		
  		flash[:success]="Appointment Successfully Updated"
  		redirect_to user_schedules_path(@user)
  	else
  		@title = "Error Updating Post"
  		render 'edit'
  	end
  
  end
  
  def show
    @user = User.find(params[:user_id])
    @appointment = Appointment.find(params[:id])
    Time.zone = @user.schedule.timezone
  end
  
  def index
  end
  
  def destroy
  end

  private
  	def correct_user
  		@client = User.find(params[:user_id])
  		redirect_to(root_path) unless current_user?(@client)
  	end
  	
  	def time_zone
  	  Time.zone = current_user.schedule.timezone 
  	end
end
