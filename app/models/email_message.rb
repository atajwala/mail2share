class EmailMessage < ActiveRecord::Base
  belongs_to :email

  def to_param
    email_body.parameterize
  end

=begin
  def self.search(search)
    if search
      find(:all, :conditions => ['email_body LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
=end

 define_index do
   indexes email_body
   indexes email.subject, :as => :email_subject
   indexes email.username, :as => :email_username
 end

end
