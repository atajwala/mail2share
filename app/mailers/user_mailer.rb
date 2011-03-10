class UserMailer < ActionMailer::Base
  default :from => "support@mail2share.com"

	def welcome_email(user)
		@user = user
		@url = "http://www.mail2share.com"
		mail(:to => user.user_email,
				 :subject => "Welcome to Mail2Share")
	end
	
	def forgot_password_email(user)
		@user = user
		@url = "http://www.mail2share.com"
		mail(:to => user.user_email,
				 :subject => "Mail2Share - forgot password?")
	end
	
	def activation_email(user)
	@user = user
	@url = "http://www.mail2share.com"
	@account_activation_url = "http://#{M2S_HOST}/activate/#{user.perishable_token}"
	mail(:to => user.user_email,
			 :subject => "Mail2Share - account activation")
	end
	
	def password_reset_email(user)
		@user = user
		@url = "http://www.mail2share.com"
		@edit_password_reset_url = "http://#{M2S_HOST}/password_resets/#{user.perishable_token}"
		mail(:to => user.user_email,
				 :subject => "Mail2Share - password reset")
	end
	
end
