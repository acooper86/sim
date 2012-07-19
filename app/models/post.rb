class Post < ActiveRecord::Base
  belongs_to :blog

  attr_accessible(:title, :content, :ptype, :tags, :categories)
end
