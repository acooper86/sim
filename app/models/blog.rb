class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :post, :dependent => :destroy
  
  attr_accessible(:title,:per_page,:allow_comments,:per_comments,:recent,:tag_cloud,:archive,:categories)
end
