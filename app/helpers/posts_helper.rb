module PostsHelper

  def edit_tag_checkboxes(blog, post)
    tag_html = ""
    posts = blog.post

    tags = create_tags(posts) unless posts.empty?
    post_tags = post.tag
    left_tags = tags - post_tags
    
    tag_html = "<h3>Current Tags</h3>"
    post_tags.each do |t|
      tag_html << check_box_tag('tag[]', t.id, true)
      tag_html << label_tag('tag', t.tag)
    end
    
    tag_html << "<h3>Other Tags</h3>"
    left_tags.each do |t|
      tag_html << check_box_tag('tag[]', t.id)
      tag_html << label_tag('tag', t.tag)
    end    
    
    tag_html << "<h3>Create New Tag:</h3>"
    5.times {|i| tag_html << label_tag("New Tag") << text_field_tag("new_tag[]")}
    
    return tag_html.html_safe
  end
  
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
  
  def tag_list(post)
    
    tags = []
    unless post.tag.empty?
      post.tag.each do |t|
        tags << t unless t.tag.blank?
      end  
    end
    
    list = "<ul>"
    unless tags.empty?  
      tags.each do |tli|
    	list << "<li>" << tli.tag << "</li>"
      end
    end
    list << "</ul>"
    
    return list.html_safe
  end

  def edit_category_select(blog, post)
    select_html = ""
    posts = blog.post

    categories = create_category(posts) unless posts.empty?
    post_category = post.category
    left_category = categories - post_category
    
    option_current = []
    current_val = ""
    post_category.each do |cat|
      option_current << [cat.name,cat.id] unless cat.name.blank?
      current_val = cat.id
    end
    
    option_other = []
    left_category.each do |cat|
      option_other << [cat.name,cat.id] unless cat.name.blank?
    end    
    
    options_hash = {'current'=> option_current, 'other'=> option_other}
    options = grouped_options_for_select(options_hash, selected_key = current_val )
    
    select_html = select_tag("category", options, :include_blank => true)
    select_html << label_tag("New Category") << text_field_tag("new_category")
    
    return select_html
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
