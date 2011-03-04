class EmailMessage < ActiveRecord::Base
	belongs_to :email
  #validates_presence_of :name
 def to_param
   email_body.parameterize
 end

 def self.search(search)
  if search
    find(:all, :conditions => ['email_body LIKE ?', "%#{search}%"])
  else
    find(:all)
  end
 end

end
