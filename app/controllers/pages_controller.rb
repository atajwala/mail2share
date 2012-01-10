class PagesController < ApplicationController
  def home
    @title = "Home"

    # To use the feed in the sample application, we add an @feed_items 
    # instance variable for the current user’s (paginated) feed
    if signed_in?
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page])
    end
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def terms
    @title = "Terms"
    respond_to do |format|
      format.html
      format.xml  { render :xml => @email }
    end
  end

end
