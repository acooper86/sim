module ServicesHelper
  
  def edit_available_main_services_select(user, service)
    services = user.service.where(:main => true)
    prereqs = service.prerequisites
    
    not_selected = services - prereqs
     
    service_html = "<h1>Available on</h1>"
    
    prereqs.each do |pre|
      service_html << check_box_tag("prereq[]", pre.id, true)
      service_html << label_tag("prereq", pre.name)
    end
    
    service_html << "<h1>Also available for</h1>"
    
    not_selected.each do |s|
      service_html << check_box_tag("prereq[]", s.id, false)
      service_html << label_tag("prereq", s.name)
    end
    
    return service_html.html_safe
  end
  
  def available_main_services_select(user)
    services = user.service.where(:main => true)
    
    service_html = ""
    
    services.each do |s|
      service_html << check_box_tag("prereq[]", s.id)
      service_html << label_tag("prereq", s.name)
    end
    
    return service_html.html_safe
  end

  def edit_avail_time(time)
    return select_tag("available[time][]", options_for_select([["Addon -- No Time", 0],["5 min.", 5],["10 min.", 10],["15 min.", 15],["20 min.", 20],["25 min.", 25],["30 min.", 30],["35 min.", 35],["40 min.", 40],["45 min.", 45],["50 min.", 50],["55 min.", 55],["1 hr.", 60],["1 hr. 15 min.", 75], ["1 hr. 30 min.", 90],["1 hr. 45 min.", 105],["2 hr.", 120],["2 hr. 30 min.",250],["3 hr.",360]], time), :include_blank => true) 
  end
  
  def edit_avail_cost(cost)
    return number_field_tag("available[cost][]",cost) 
  end

  def new_avail_time
    return select_tag("available[time][]", options_for_select([["Addon -- No Time", 0],["5 min.", 5],["10 min.", 10],["15 min.", 15],["20 min.", 20],["25 min.", 25],["30 min.", 30],["35 min.", 35],["40 min.", 40],["45 min.", 45],["50 min.", 50],["55 min.", 55],["1 hr.", 60],["1 hr. 15 min.", 75], ["1 hr. 30 min.", 90],["1 hr. 45 min.", 105],["2 hr.", 120],["2 hr. 30 min.",250],["3 hr.",360]]), :include_blank => true) 
  end
  
  def new_avail_cost
    return number_field_tag("available[cost][]") 
  end
  
  def available_duration(key)
    secs = key.to_i * 60
    mins = secs / 60
    hours = mins / 60
    days = hours / 24
    
    if days > 0
      if days <2
        "One day and #{hours % 24} hours"
      else
        "#{days} days and #{hours % 24} hours"
      end
    elsif hours > 0 
      if hours < 2
        "One hour and #{mins % 60} minutes"
      else
       "#{hours} hours and #{mins % 60} minutes"
      end
    elsif mins > 0
      "#{mins} minutes"
    else
      "Add-on"
    end
  end
  
end
