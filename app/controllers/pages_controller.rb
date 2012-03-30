class PagesController < ApplicationController
  def home
  	@title = "Home"
  end

  def about
  	@title = "About"
  end

  def contact
  	@title = "Contact"
  end
  
  def affliate
  	@title = "Affliate"
  end
  
  def support
  	@title = "Support"
  end
end
