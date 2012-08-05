class StaticsController < ApplicationController
	
  def home
  	forward_check
  	@title = "Home"
  	@user = User.new
  	@environment = request.env
  end

  def about
  	@title = "About"
  end
  
  def affliate
  	@title = "Affliate"
  end
end
