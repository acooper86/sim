class Category < ActiveRecord::Base
	has_many :post_category
	has_many :post, :through => :post_category
end
