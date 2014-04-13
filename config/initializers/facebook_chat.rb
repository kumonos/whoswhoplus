require 'facebook_chat'

FacebookChat::Client.configure do |config|
  config.api_key = CLIENT_TOKEN # your facebook application's api key
  config.host = 'chat.facebook.com' # you can omit this line. Default host value is 'chat.facebook.com'
end
