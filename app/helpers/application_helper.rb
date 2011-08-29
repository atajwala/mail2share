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
  
end

