module ServicesHelper
  
  def available_main_services_select(user)
    services = user.service.where(:main => true)
    
    service_html = ""
    
    services.each do |s|
      service_html << check_box_tag("prereq[]", s.id)
      service_html << label_tag("prereq", s.name)
    end
    
    return service_html.html_safe
  end

  def new_avail_time
    return select_tag("available[time][]", options_for_select([["5 min.", 5],["10 min.", 10],["15 min.", 15],["20 min.", 20],["25 min.", 25],["30 min.", 30],["35 min.", 35],["40 min.", 40],["45 min.", 45],["50 min.", 50],["55 min.", 55],["1 hr.", 60],["1 hr. 15 min.", 75], ["1 hr. 30 min.", 90],["1 hr. 45 min.", 105],["2 hr.", 120],["2 hr. 30 min.",250],["3 hr.",360]])) 
  end
  
  def new_avail_cost
    return number_field_tag("available[cost][]") 
  end
  
end
