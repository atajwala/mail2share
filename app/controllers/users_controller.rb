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
		if @user.save_without_session_maintenance
		  @user.deliver_activation_instructions!
		  flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
			redirect_to("/")
		else
			render :action => :new
		end	
	end

=begin
	def index
		#current_user.inspect
		@usermsgs = Email.paginate_by_user_id("#{current_user.id}", :page => params[:page], :order => 'updated_at DESC', :per_page => 30)
		#@usermsgs.inspect
	end
	
	def show
		@mail = Mail.read(params[:dir_path])
		
		if (@mail.multipart?)
		  @body = @mail.text_part.decoded
		else
		  @body = @mail.decoded
		end
	end

=end
	
	def update
		@user.update_attributes()
	end
	
	def destroy
	end
	

end
