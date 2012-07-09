class Website < ActiveRecord::Base
	include WebsitesHelper
	belongs_to :user
	has_many :page, :dependent => :destroy
	
	attr_accessible(:user_id, :title, :theme, :motto, :domain, :order, :description, :keywords)
	
	serialize :order, Array
	
	website_regex = /[a-z0-9]*\W?[a-z0-9]*\.(biz|ca|com|co|co\.uk|de|eu|in|info|me|me.uk|mobi|net|org|org.uk|us)/
	
	validates :domain, :presence => true,
					   :format => {:with => website_regex},
					   :uniqueness => {:case_sensitive => false}
					   
	def updateOrder(page_id)
		order = self.order
		order.delete(page_id)
		self.update_attribute(:order, order)
	end
	
	def publish_site
		domain = self.domain
		title = self.title
		motto = self.motto
		theme = self.theme
		order = self.order
		user_id = self.user_id
		
		css = writeCss(theme)
		nav = pageNav(self)
		js = writeJs(theme)
		footer = writeFooter(user_id)
		
		top = createTop(title,motto,theme,css,nav)
		bottom = createBottom(js,footer)
		
		#need to write a method to clean out the domain folder
		
		order.each do |p|
			page = Page.find(p)
			content = writeContent(page)
			file_name = page.ptitle.gsub(/\s+/, "") << ".html"
		    
		    writeFile(domain,file_name,top,bottom,content)
		end
	end
	
	def writeFile(domain, file_name, top, bottom,content)
		path = "public/"<< domain << "/" << file_name 
		file = File.new(path,"w")
		file.puts(top)
		file.puts(content)
		file.puts(bottom)
		file.close
	end
end
