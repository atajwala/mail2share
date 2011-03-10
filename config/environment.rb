# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Mail2share::Application.initialize!

require 'socket'
#M2S_HOST = request.host_with_port
M2S_HOST = Socket.gethostname


# Memcache configurations
require 'memcache'
require 'cached_model'

#memcache_options = {
#  :c_threshold => 10_000,
#  :compression => true,
#  :debug => false,
#  :namespace => 'my_rails_app',
#  :readonly => false,
#  :urlencode => false
#}

#CACHE = MemCache.new memcache_options
#CACHE.servers = 'localhost:11211'
CACHE = MemCache.new('127.0.0.1')

# Mailer configurations
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 25,
  :domain => "gmail.com",
  :user_name => "mail2share.aws",
  :password => "Share2Mail",
  :authentication => :login
}
