class ActivationsController < ApplicationController
  def create
	  @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    raise Exception if @user.active?
		
    if @user.activate!
      flash[:notice] = "Your account has been activated!"
      UserSession.create(@user, false) # Log user in manually
			print Rails.logger.info("********************START***************************")
			
			whoami = `whoami`
			print Rails.logger.info("whoami #{whoami}")
						
			whoami = `chmod 777 /mail2share/mbox`
			whoami = `mkdir /mail2share/mbox/"#{@user.username}"`
			print Rails.logger.info("mkdir #{whoami}")
			
			whoami = `chown apache /mail2share/mbox/"#{@user.username}"`
			print Rails.logger.info("chown #{whoami}")
			
			whoami = `chgrp mail2share /mail2share/mbox/"#{@user.username}"`
			print Rails.logger.info("chgrp #{whoami}")
			
			whoami = `chmod 777 /mail2share/mbox/"#{@user.username}"`
			print Rails.logger.info("chmod #{whoami}")
			
			whoami = `chmod 777 /etc/postfix/virtual`
			whoami = `chmod 777 /etc/postfix/virtual.db`
			whoami = `echo '#{@user.username}@mail2share.com   #{@user.username}/' >> /etc/postfix/virtual`
			print Rails.logger.info("virtual #{whoami}")
			
			whoami = `/usr/sbin/postmap /etc/postfix/virtual`
			print Rails.logger.info("postmap #{whoami}")
			
			print Rails.logger.info($?)
			
			print Rails.logger.info("********************STOP****************************")
			
      @user.deliver_welcome!
			redirect_to("/#{@user.username}")
    else
      render :action => :new     
		end
  end

end
