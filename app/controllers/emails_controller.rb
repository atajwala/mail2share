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


    @user_emails = Email.where("username = ?", params[:username])
    @emails = @user_emails.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 10

    respond_to do |format|
      format.html # inbox.html.erb
      format.xml  { render :xml => @email }
    end
  end

  def messages
        @email = Email.find_by_file_key(params[:file_key])
        @message = Mail.read("/home/mail2share/mbox/#{@email.username}/#{@email.file_name}")
       # @email = Email.where("file_key = ?", params[:file_key])


        if (@message.multipart?)
#          @body = @message.text_part.decoded
           @body = @message.html_part
        else
          @body = @message.decoded
          @body = @body.to_s
        end

        respond_to do |format|
          format.html
          format.xml { head :ok }
        end
  end

end
