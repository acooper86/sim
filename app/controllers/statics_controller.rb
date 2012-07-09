class StaticsController < ApplicationController
	
  def home
  	forward_check
  	@title = "Home"
  end

  def about
  	@title = "About"
  end
  
  def affliate
  	@title = "Affliate"
  end
end
