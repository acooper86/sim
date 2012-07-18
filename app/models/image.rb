class Image < ActiveRecord::Base
	belongs_to :user
	
	attr_accessible(:name, :alt, :user_id, :image, :remote_image_url, :profile, :logo)
	
	validates :name, :presence => true
	
	mount_uploader :image, ImageUploader
end
