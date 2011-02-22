class ActivationsController < ApplicationController
  def create
	  @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    raise Exception if @user.active?
		
    if @user.activate!
      flash[:notice] = "Your account has been activated!"
      UserSession.create(@user, false) # Log user in manually
      @user.deliver_welcome!
			redirect_to("/#{@user.username}")
    else
      render :action => :new     
		end
  end

end
