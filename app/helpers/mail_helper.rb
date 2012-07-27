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
  
  def theme(theme_name)
    case theme_name
      when 'green' 
        @@green_settings
      when "grey"
        @@standard_grey_settings
      else
        @@standard_grey_settings
    end
  end

  #### Settings hashes available to all html_email theme methods
  @@green_settings = { 
         #background table setttings
         :back_bgcolor => "329632", :back_border => "border:5px solid #e4fde3;", 
         #content cell settings
         :body_wrap_cellspacing => "0", :body_wrap_cellpadding => "10", 
         #header cell settings
         :head_cellspacing => "0", :head_cellpadding => "0", :head_text_align => "text-align:left;",
         #logo cell settings
         :logo_wrap_width => "150", :logo_image_width => "140",
		 #hgroup settings   
         :hgroup_wrap => "350", :hgroup_color => "color:white;", :hgroup_font => 'font-family:"Arial Black",Gadget,sans-serif;', 
         :hgroup_h1_font_size => "font-size: 3em;", :hgroup_h1_font_style => "font-style: italic;",  :hgroup_h1_margin_bottom => "margin-bottom:-10px;",
         :hgroup_h2_font_size => "font-size: 1.5em;", :hgroup_h2_font_style => "font-style: none;",  :hgroup_h2_margin_bottom => "margin-bottom:0px;",
         #content settings
         :content_wrap_width => "550", :content_wrap_bgcolor => "ffffdc", :content_wrap_style => "border:2px solid #005023;",
         #footer settings
         :footer_wrap_width => "500", :footer_wrap_bgcolor => "", :footer_wrap_style => "color:white;text-align:center; line-height:50%;" 
         }
         
  @@standard_grey_settings = { 
         #background table setttings
         :back_bgcolor => "efefef", :back_border => "border:5px solid #777777;", 
         #content cell settings
         :body_wrap_cellspacing => "0", :body_wrap_cellpadding => "10", 
         #header cell settings
         :head_cellspacing => "0", :head_cellpadding => "0", :head_text_align => "text-align:left;",
         #logo cell settings
         :logo_wrap_width => "150", :logo_image_width => "140",
		 #hgroup settings   
         :hgroup_wrap => "350", :hgroup_color => "color:black;", :hgroup_font => 'font-family:"Arial Black",Gadget,sans-serif;', 
         :hgroup_h1_font_size => "font-size: 3em;", :hgroup_h1_font_style => "font-style: italic;",  :hgroup_h1_margin_bottom => "margin-bottom:-10px;",
         :hgroup_h2_font_size => "font-size: 1.5em;", :hgroup_h2_font_style => "font-style: none;",  :hgroup_h2_margin_bottom => "margin-bottom:0px;",
         #content settings
         :content_wrap_width => "550", :content_wrap_bgcolor => "ffffff", :content_wrap_style => "border:2px solid #777777;",
         #footer settings
         :footer_wrap_width => "500", :footer_wrap_bgcolor => "", :footer_wrap_style => "color:black;text-align:center; line-height:50%;" 
         }



end
