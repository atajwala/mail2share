class UsersController < ApplicationController
	#before_filter :require_no_user, :only => [:new, :create]
	#before_filter :require_user, :only => [:show, :edit, :update]

	def new
		@user = User.new
	end
	
	def create
		@user = User.new(params[:user])
		# Saving without session maintenance to skip
		# auto-login which can't happen here because
		# the user has not yet been activated
		if @user.save_without_session_maintenance and verify_recaptcha
		  @user.deliver_activation_instructions!
		  flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
			redirect_to("/")
		else
			render :action => :new
		end	
	end


	def index
		@users = User.where(:active => true).paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 10)
	end
	
	def update
		@user.update_attributes()
	end
	
	def destroy
	end
	

end
