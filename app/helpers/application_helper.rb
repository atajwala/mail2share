module ApplicationHelper
 # Return a title on a per-page basis.
  def title
    base_title = "Mail2Share - Public Inbox"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def logo
    image_tag("m2s_logo.png", :alt => "Mail2Share", :class => "round")
  end

  def aslam_logo
		image_tag("me.jpg", :alt => "Aslam Tajwala", :size => "100")
	end

  def userlogo
		image_tag("profile.png", :alt => "Default user profile picture", :class => "round")
	end

	def pretty_date(date)
	  return date unless date.is_a?(Time)
	  return date.strftime("%B %d %Y, %r") unless Time.now.year == date.year
	  date.strftime("%B %d, %r")
	end
  
end

