module ApplicationHelper
	def title
		base_title = "Simplissage Web Promotion for Massage Therapists"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
end
