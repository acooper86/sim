module PostsHelper

  def tag_checkboxes(blog)
    posts = blog.post
    tags = create_tags(posts) unless posts.empty?
    
    tag_checks = ""
    tags.each do |t|
          tag_checks << check_box_tag('tag', t.id) 
          tag_checks << label_tag('tag', t.tag)
    end
    
    return tag_checks.html_safe
  end

  def create_tags(posts)
  tags = []
    
    posts.each do |post|
      unless post.tag.empty?
        post.tag.each do |t|
          tags << t unless t.tag.blank?
        end
      end
    end
    
    return tags.to_set
  end

  def category_select(blog)
    posts = blog.post
    categories = create_category(posts) unless posts.empty?
    
    cat_options = []
    categories.each do |cat|
          cat_options << [cat.name,cat.id]
    end
    
    return select_tag("category",options_for_select(cat_options), :include_blank => true).html_safe
  end

  def create_category(posts)
    categories = []
    
    posts.each do |post|
      unless post.category.blank?
        post.category.each do |cat|
          categories << cat unless cat.name.blank?
        end
      end
    end
    
    return categories.to_set
  end
  
end
