require 'mail'

class EmailsController < ApplicationController
  def inbox
    #@email = Email.find(params[:username])
   # @emails = Email.find_by_username(params[:username])
     #@emails = Email.where("username = ?", params[:username])
    # @user = Email.where("username = ?", params[:username])
     #@emails = Email.paginate_by_user_id("#{@user.id}", :page => params[:page], :order => 'updated_at DESC', :per_page => 20)
    #@user_emails = Email.where("username = ?", params[:username])
    #@emails = Email.paginate_by_username("#{params[:username]}", :page => params[:page], :order => 'updated_at DESC', :per_page => 20)


    @user_emails = Email.where("username = ? and delete_flag = ?", params[:username], 0)
    @emails = @user_emails.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 10

    respond_to do |format|
      format.html # inbox.html.erb
      format.xml  { render :xml => @email }
    end
  end

  def messages
        @email = Email.find_by_file_key(params[:file_key])
        @message = Mail.read("/webapps/mbox/#{@email.username}/#{@email.file_name}")
       # @email = Email.where("file_key = ?", params[:file_key])


        if (@message.multipart?)
          #@body = @message.text_part.decoded
           @body = @message.html_part.decoded
           #coder = HTMLEntities.new
            #coder.encode(@body, :named)
           
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
    flash[:success] = "Email(s) removed from public inbox!"
    #redirect_to email_path
    redirect_to :back
  end

end
