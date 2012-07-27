class ContactController < ApplicationController

	def new
		@title= "Contact Us"
		@message = Message.new
	end
	
	def create
		@message = Message.new(params[:message])
		
		if @message.valid?
			NotificationMailer.new_message(@message).deliver
			redirect_to(root_path, :success => "Message wass successfully sent")
		else
			flash.now.alert = "Please fill in all fields."
			render :new
		end
	end
	
end
