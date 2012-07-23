class Post < ActiveRecord::Base
  belongs_to :blog
  
  has_many :post_tags, :dependent => :destroy
  has_many :tag, :through => :post_tags, :dependent => :destroy 

  has_many :post_categories, :dependent => :destroy
  has_many :category, :through => :post_categories, :dependent => :destroy 
  
  attr_accessible(:title, :content, :ptype, :categories, :image, :video, :block_quote, :q_author, :href, :link_text,:remote_image_url, :tag_attributes)
  
  accepts_nested_attributes_for :tag, :allow_destroy => true
  
  mount_uploader :image, ImageUploader

 

end
