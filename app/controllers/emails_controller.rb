require 'mail'

class EmailsController < ApplicationController
  def inbox	
		@user = User.where("username = ? and active = ?", params[:username], TRUE)
		if @user.empty?
			#flash[:error] = "Sorry. User #{params[:username]} does not exist, #{ link_to "SignUp", "users/new" } to create one."
			flash[:error] = "Sorry. User \"#{params[:username]}\" does not exist, SignUp to create one."
			redirect_to :root
			return
		end

		@is_this_me = FALSE
		@this_user = current_user
		print Rails.logger.info(@this_user.inspect)
    if (@this_user and @this_user.username == params[:username])
	    @is_this_me = TRUE
	  end

		@user_hash = Hash.new
    @user_emails = Email.where("username = ? and delete_flag = ?", params[:username], 0)
   
		@user_emails.each do |sender|
	    @tmp_user = User.find_by_user_email(sender.sender_email)
	    if @tmp_user
				print Rails.logger.info(@tmp_user.inspect)
				@user_hash[sender.file_name] = @tmp_user.fullname
			else
				@user_hash[sender.file_name] = "unknown"
		  end
	  end
    
		@emails = @user_emails.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 12
    @username =  params[:username]
    respond_to do |format|
      format.html # inbox.html.erb
      format.xml  { render :xml => @email }
    end
  end

  def messages
        @email = Email.find_by_file_key(params[:file_key])
        @message = Mail.read("/mail2share/mbox/#{@email.username}/#{@email.file_name}")
        @share_url = "http://mail2share.com/" + params[:username] +  "/" + params[:file_key]

        if (@message.multipart?)
           @body = @message.html_part.decoded
=begin
           @body_sanitized = @body.gsub(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, '####@####.##')
					 print Rails.logger.info("!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
					 print Rails.logger.info("#{@body_sanitized.to_s}")
					 print Rails.logger.info("!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
=end      
  		else
          @body = @message.decoded
          @body = @body.to_s
        end

        respond_to do |format|
          format.html
          format.xml { head :ok }
        end
  end

  #added by shams for delete as update
  #we wont be deleting but we will be updating the table with the flag to fetch records that are not flagged as delete

  def update_emails
    #update the attributes that gets passed
    #accessing the array the following returns an array of selected ids from the email page
    #Email.update(["delete_flag=?",1], :id => params[:email_ids])
    #params[:email_ids]
    #update_emails = Email.where("id in ?", params[:email_ids])
    #update_emails.delete_flag = 1
    Email.update_all(["delete_flag=?, updated_at=?", 1, Time.now], :id => params[:email_ids])
    flash[:success] = "#{params[:email_ids].length} Email(s) deleted from inbox!"
    #redirect_to email_path
    redirect_to :back
  end

end
