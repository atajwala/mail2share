class Email < ActiveRecord::Base
	belongs_to :user

def to_param
  #he String instance method parameterize will ensure the 
  #string is URL appropriate.
 username.parameterize
 file_key.parameterize
end


end