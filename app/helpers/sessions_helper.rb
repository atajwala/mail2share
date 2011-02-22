module SessionsHelper

 def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
 end

 def current_user=(user)
    @current_user = user
 end

 def current_user
    @current_user ||= user_from_remember_token
 end

  def signed_in?
    !current_user.nil?
  end
 

 def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
 end

  #this is called from UserController when it filters for :corect_user
  def current_user?(user)
    user == current_user
  end


  #moved  this method from users_controller as its needed by the 
  #blogs as well
  def authenticate
    deny_access unless signed_in?
  end


  #uses a shortcut for setting flash[:notice] by passing an options hash to the redirect_to function. 
  def deny_access
   #In order to forward users to their intended destination, we need to store the location of the requested page somewhere, and then redirect there instead. The storage mechanism is the session facility provided by Rails
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."

  end


  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end


  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
 
    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end
end
