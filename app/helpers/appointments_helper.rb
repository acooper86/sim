module AppointmentsHelper
  def available_services_select(user)
    services = user.service.where(:main => true)
    addon = user.service.where(:main => false)
    
    service_html = "<h1>Available Main Services</h1>"
    
    services.each do |service|
      service_html << check_box_tag("service[]", service.id)
      service_html << label_tag("service", service.name)
    end
    
    service_html << "<h1>Available Addon Services</h1>"
    
    addon.each do |s|
      service_html << check_box_tag("service[]", s.id)
      service_html << label_tag("service", s.name)
    end
    
    return service_html.html_safe
  end
  
  def contact_options(user)
  	
  	contacts = user_contacts(user)
    
    contact_options = []
    contacts.each do |c|
    	contact_options << [c.first_name << " " << c.last_name, c.id]
    end  	
  	
  	return contact_options
  end
  
  def user_contacts(user)
  	return user.contact
  end
  
  
  ######### Edit Modules
  
  def edit_appointment_services(user, app)
    available_services = user.service.where(:main => true)
    available_addons = user.service.where(:main => false)
    
    current_services = app.service
    
    html = "<h1>Current Services</h1>"
    
    current_services.each do |cs|
      html << check_box_tag("service[]", cs.id, :checked => true)
      html << label_tag("service", cs.name)
    end
    
    html << "<h1>Other Available Main Services</h1>"
    
    available_services = available_services - current_services
    
    available_services.each do |as|
      html << check_box_tag("service[]", as.id)
      html << label_tag("service", as.name)
    end
    
    html << "<h1>Other available Addons</h1>"
    
    available_addons = available_addons - current_services
    
    available_addons.each do |aa|
      html << check_box_tag("service[]", aa.id)
      html << label_tag("service", aa.name)
    end
    
    return html.html_safe
  end
end
