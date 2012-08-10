class View::ViewportController < ApplicationController
  layout false
  
  def home
    @website = Website.find_by_domain(request.host)
    @page = Page.find(@website.order.first)
    @user = User.find(@website.user_id)
  end

  def show
    @website = Website.find_by_domain(request.host)
    @page = Page.find_by_ptitle(params[:page_name])
    @user = User.find(@website.user_id)
    
    unless @page
      redirect_to view_root_path
    end
  end

end
