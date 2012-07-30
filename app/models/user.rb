require 'digest'

class User < ActiveRecord::Base
	has_one :website, :dependent => :destroy
	has_many :page, :through => :website
	
	has_one :blog, :dependent => :destroy
	has_many :post, :through => :blog
	
	has_one :schedule, :dependent => :destroy
	
	has_many :image, :dependent => :destroy
	has_many :contact, :dependent => :destroy
	has_many :contact_message, :dependent => :destroy
	has_many :news_message, :dependent => :destroy

	attr_accessor :password
	attr_accessible(:first_name, :last_name, :email, :password, :password_confirmation,:address_l1,
						:address_l2, :city, :state, :zip, :telephone, :business, :website, :activated)
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :first_name, :presence => true,
				:length => {:maximum => 50}
	validates :last_name, :presence => true,
				:length => {:maximum => 50}
	validates :email, :presence => true,
				:format => {:with => email_regex},
				:uniqueness => {:case_sensitive => false}
				
	validates :password, :presence => true, 
				:confirmation => true,
				:length => {:within => 6..40},
				:on => :create
				
	before_save :encrypt_password
	
	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end
	
	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end
	
	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id) 
		(user && user.salt == cookie_salt) ? user : nil
	end
	
	def send_password_reset
		generate_token(:password_reset_token)
		self.update_column(:password_reset_sent_at, Time.zone.now)
		UserMailer.password_reset(self).deliver
	end
	
	def send_activation
		generate_token(:activated)
		UserMailer.activate(self).deliver
	end
	
	def set_activation
		self.update_column(:activated,true)
	end
	
	private
		def generate_token(column)
				self.update_column(column, SecureRandom.urlsafe_base64)
		end
		
		def encrypt_password
			self.salt = make_salt unless has_password?(password)
			self.encrypted_password = encrypt(password)
		end
		
		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end
		
		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end
		
		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
end
