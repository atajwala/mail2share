class PasswordResetsController < ApplicationController
	before_filter :load_mailuser_using_perishable_token, :only => [:edit, :update] 
	
	def new
		render
	end
	
	def create
		@user = User.find_by_user_email(params[:email])  
		if @user  
			@user.deliver_password_reset_instructions!  
			flash[:notice] = "Instructions to reset your password have been emailed to you. Please check your email."  
			redirect_to("/#{@user.username}")  
		else  
			flash[:notice] = "No user was found with that email address"  
			render :action => :new  
		end  
	end  
	
	def edit  
		render  
	end  

	def update
		@user = User.update_attributes(params[:password]) 
		#@user.password = params[:password]  
		#@user.password_confirmation = params[:user][:password_confirmation]  
		if @user.save  
			flash[:notice] = "Password successfully updated"  
			redirect_to account_url  
		else  
			render :action => :edit  
		end  
	end 
	
	def deactivate
		if current_user.deactivate!
      flash[:error] = "Your account has been deleted! Hope to see you again."
=begin
			@user = current_user_session
			print Rails.logger.info("********************START***************************")
			
			whoami = `whoami`
			print Rails.logger.info("whoami #{whoami}")
						
			whoami = `rm -rf /mail2share/mbox/"#{@user.username}"`
			print Rails.logger.info("rm dir #{whoami}")
			
			whoami = `chmod 777 /etc/postfix/virtual`
			whoami = `chmod 777 /etc/postfix/virtual.db`
			whoami = `sed -e "/#{@user.username}/d" /etc/postfix/virtual > /etc/postfix/vitrual.tmp`
			whoami = `mv /etc/postfix/virtual.tmp /etc/postfix/virtual`
			print Rails.logger.info("del virtual #{whoami}")
			
			whoami = `/usr/sbin/postmap /etc/postfix/virtual`
			print Rails.logger.info("postmap #{whoami}")
			print Rails.logger.info($?)
			
			print Rails.logger.info("********************STOP****************************")
=end
			current_user_session.destroy
			redirect_to(root_url)
    else
			flash[:notice] = "Oops! There was a problem deactivating your account. Please contact support@mail2share.com"
		end
	end 

	private  
	
	def load_mailuser_using_perishable_token  
		@user = User.where("perishable_token = ?", params[:id])  
		unless @user  
			flash[:notice] = "We're sorry, but we could not locate your account. " +  
			"If you are having issues try copying and pasting the URL " +  
			"from your email into your browser or restarting the " +  
			"reset password process."  
			redirect_to root_url  
		end
  end  

end
