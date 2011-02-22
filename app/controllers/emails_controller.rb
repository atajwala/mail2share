require 'mail'

class EmailsController < ApplicationController
  def inbox
    #@email = Email.find(params[:username])
   # @emails = Email.find_by_username(params[:username])
     @emails = Email.where("username = ?", params[:username])
    respond_to do |format|
      format.html # inbox.html.erb
      format.xml  { render :xml => @email }
    end
  end

  def messages
        @email = Email.find_by_file_key(params[:file_key])
        @message = Mail.read("/Users/shams/rubyonrails/mail2share_aslam/messages/#{@email.file_name}")
       # @email = Email.where("file_key = ?", params[:file_key])


        if (@message.multipart?)
          @body = @message.text_part.decoded
        else
          @body = @message.decoded
        end

        respond_to do |format|
          format.html
          format.xml { head :ok }
        end
  end

end
