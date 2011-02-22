class UserMailer < ActionMailer::Base
  default :from => "support@mail2share.com"

	def welcome_email(user)
		@user = user
		@url = "http://www.mail2share.info"
		mail(:to => user.user_email,
				 :subject => "Welcome to Mail2Share")
	end
	
	def forgot_password_email(user)
		@user = user
		@url = "http://www.mail2share.info"
		mail(:to => user.user_email,
				 :subject => "Mail2Share - forgot password?")
	end
	
	def activation_email(user)
	@user = user
	@url = "http://www.mail2share.info"
	@account_activation_url = "http://localhost:3000/activate/#{user.perishable_token}"
	mail(:to => user.user_email,
			 :subject => "Mail2Share - account activation")
	end
	
	def password_reset_email(user)
		@user = user
		@url = "http://www.mail2share.info"
		@edit_password_reset_url = "http://localhost:3000/password_resets/#{user.perishable_token}"
		mail(:to => user.user_email,
				 :subject => "Mail2Share - password reset")
	end
	
end
