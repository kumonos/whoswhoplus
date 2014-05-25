require 'facebook_chat'

FacebookChat::Client.configure do |config|
  config.api_key = defined?(CLIENT_TOKEN) ? CLIENT_TOKEN : 'DUMMY'
end
