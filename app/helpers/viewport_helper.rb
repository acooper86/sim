module ViewportHelper
  
  def page_content(page)
    if @page.content 
	  @page.content.html_safe 
	else 
	  "<h1>No Content</h1>".html_safe
	end 
  end
end
