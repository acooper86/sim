module MailHelper
	
  def recipient_select(user)
  	recipient_html = ""
  	
  	contacts = user_contacts(user)
    contact_options = []
    contacts.each do |c|
    	contact_options << [c.first_name << " " << c.last_name, c.id]
    end  	
  	contact_options = options_for_select(contact_options)
  	
  	recipient_html << "<h3>Pick your recipients</h3>"<< select_tag("contacts", contact_options, :multiple => true)
  	
  	recipient_html << "<h3>Or new emails</h3>" << text_field(:contact_message, :recipients)
  	return recipient_html.html_safe
  end
  
  def user_contacts(user)
  	return user.contact
  end
  
  def recipients(dm)
    recs = ""
    i = 0
    dm.recipients.each do |rec|
    	recs << ", " unless i == 0
    	if rec.include?("@")
    	  recs << rec
    	else 
    	  c = Contact.find(rec)
    	  recs << c.first_name << " " << c.last_name
    	end
        i += 1
    end
    return recs
  end
end
