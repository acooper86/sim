module WebsitesHelper
	def pageList(website)
		@order = website.order
		@page_list = Array[]
		
		@order.each do |o|
				@page_list << Page.find_by_id(o)
		end	
		
		return @page_list
	end
	
	def pageNav(website)
		@li_list=""
		@page_list = pageList(website)
		@page_list.each do |p|
			if (p.indexed == true)
				if (p.child == false)
					@li = "<li><a href=\"/view/"<< p.ptitle.gsub(/\s+/, "") << ".html\">"
					@li << p.ptitle
					@li << "</a></li>"
					@li_list<<@li
				else
					@li = "<li><ul><li><a href=\"/"<< p.ptitle.gsub(/\s+/, "") << ".html\">"
					@li << p.ptitle
					@li << "</a></li>"
					@li_list<<@li
				end
			end 
		end
		
		return @li_list.html_safe
	end
	
	def createTop(title, motto, theme, css, nav)
	
		top_string = "<!DOCTYPE html><head><title>" << title << motto << "</title>"<< css <<"</head>"
		top_string << "<body><header><hgroup><h1>" << title << "</h1><h2>" << motto << "</h2></hgroup>"
		top_string << "<nav><ul>"<< nav << "</ul></nav></header>"
		top_string << '<section><div id="box">'
		return top_string
	end
	
	def createBottom(js,footer)
	
		bottom_string = "</div></section>"
		bottom_string << footer
		bottom_string << js << "</body></html>"
		
		return bottom_string
	end
	
	def writeFooter(id)
		user = User.find(id)
		if user.business
			business = user.business
		else
			business = "Licensed Massage Therapist"
		end
		
		
		foot_string ="<footer><p>&copy"<< user.first_name << " " << user.last_name << "</p>"
		foot_string << "<p>" << business << "</p>"
		foot_string << '<p>Powered by <a href="simplissage.com">Simplissage</a></p>'
		foot_string << "</footer>"
		
		return foot_string
	end
	
	def writeJs(theme)
		js_string = '<script type="text/javascript" src="/assets/jquery.js"></script>
			<script type="text/javascript" src="/assets/jquery_ujs.js"></script>'
		
		return js_string
	end
	
	def writeCss(theme)
		css_string = '<link type="text/css" rel="stylesheet" media="screen" href="/assets/reset.css"/>/n
		<link type="text/css" rel="stylesheet" media="screen" href="/assets/public.css"/>/n
		<link type="text/css" rel="stylesheet" media="screen" href="/assets/' << theme << '"/>'
	
		return css_string
	end
	
	def writeContent(page)
		if page.content
			content = page.content
		else
			content = "<h1>This page is under construction!<h1><p>Please excuse the mess. This page will be live soon!</p>"
		end
		
		return content
	end

end




