class EmailMessagesController < ApplicationController

  def index
    @emails = EmailMessage.search(params[:search])
    #@emails = @searched_emails.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 10

  end

end
