class Post < ActiveRecord::Base
  belongs_to :blog
  
  has_many :post_tags
  has_many :tag, :through => :post_tags

  accepts_nested_attributes_for :tag, :reject_if => proc {|attr| attr[:tag].blank?}

  has_many :post_categories
  has_many :category, :through => :post_categories
  
  accepts_nested_attributes_for :category, :reject_if => proc {|attr| attr[:name].blank?}
 
  attr_accessible(:title, :content, :ptype, :categories, :image, :video, :block_quote, :q_author, :href, :link_text,:remote_image_url, :tag_attributes, :category_attributes)
  
  mount_uploader :image, ImageUploader

end
