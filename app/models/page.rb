class Page < ActiveRecord::Base
	
	belongs_to :website
	
	attr_accessible(:indexed, :content,:ptype, :child, :ptitle)
	
	validates :ptitle, :presence => true
	
	def page_content_fix(user)
	  strip_special_content
	  add_special_content(user) unless self.ptype == 'normal'
	end
	
	protected  
	def strip_special_content
	  self.update_column(:content, stripped_content)
	end
	
	def stripped_content
	  return self.content.gsub('/<section class="plug.*<\/section>/i','')
	end
	  
	def add_special_content
	  self.update_column(:content, special_content)
	end
	  
	def sepecial_content
	  if self.ptype == 'contact'
	    content = self.content + '<section class="plug contact">' + contact_form(user) + '</section>'
	  end
	end
	  
	def contact_form_for(user)
      html = '<form method="post" id="new_message" class="new_message" action="http://simplissage.com/users/' + user.id + '/message" accept-charset="UTF-8">
        <div style="margin:0;padding:0;display:inline">
          <input type="hidden" value="&#x2713;" name="utf8">
        </div>
  
          <fieldset class="fields">
          <div class="field">
           <label for="message_name">Name</label>
	      <input type="text" size="30" name="message[name]" id="message_name">
          </div>

          <div class="field">
	      <label for="message_email">Email</label>
	       <input type="text" size="30" name="message[email]" id="message_email">
          </div>
		
          <div class="field">
	      <label for="message_subject">Subject</label>
	      <input type="text" size="30" name="message[subject]" id="message_subject">
	      </div>
		
	      <div class="field">
	      <label for="message_body">Message</label>
	      <br>
	      <textarea rows="20" name="message[body]" id="message_body" cols="40"></textarea>
    	  </div>
          </fieldset>
	
          <fieldset class="actions">
            <input type="submit" value="Send" name="commit">
          </fieldset>
          </form>'
        return html
     end
end
