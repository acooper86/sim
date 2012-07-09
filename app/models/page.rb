class Page < ActiveRecord::Base
	belongs_to :website
	
	attr_accessible(:indexed, :content,:ptype, :child, :ptitle)
	
	validates :ptitle, :presence => true
	
end
