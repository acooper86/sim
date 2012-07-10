module ApplicationHelper
	def title
		base_title = "Simplissage Web Promotion for Massage Therapists"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
	
	def javascript(*files)
		content_for(:foot){javascript_include_tag(*files)}
	end
	
	def stylesheet(*files)
		content_for(:head) {stylesheet_link_tag(*files)}
	end
	
end
