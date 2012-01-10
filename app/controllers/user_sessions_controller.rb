class UserSessionsController < ApplicationController
  #before_filter :require_no_user, :only => [:new, :create]
  #before_filter :require_user, :only => :destroy
  
  def new  
    if current_user
      redirect_to("/#{current_user.username}")
    else
      @user_session = UserSession.new
    end
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])

    if @user_session.save
      flash[:notice] = "Login successful."
      redirect_to("/#{@user_session.username}")
    else
      flash[:error] = "Wrong username/password combination. Please check and try again."
      redirect_to("/")
    end
  end

  def update
    @user_session = UserSession.update_attributes(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful."
      redirect_to("/#{@user_session.username}")
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout was successful."
    redirect_to("/")
    #redirect_back_or_default new_user_session_url
  end

end
