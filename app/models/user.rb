class User < ActiveRecord::Base
	has_many :emails
	
	acts_as_authentic do |c|
	  c.require_password_confirmation = false
		#c.validate_email_field = false
		#c.validate_login_field = false
		#c.validate_password_field = false
		#c.email_field = 'user_email'
		#c.login_field = 'username'
	end
	
	def activate!
	    self.active = true
	    save
	end
	
	def deliver_activation_instructions!
	    reset_perishable_token!
			UserMailer.activation_email(self).deliver
	end

	def deliver_welcome!
	  reset_perishable_token!
		UserMailer.welcome_email(self).deliver
	end
	
	def deliver_password_reset_instructions!
		reset_perishable_token!  
		UserMailer.password_reset_email(self).deliver
	end
	
end
