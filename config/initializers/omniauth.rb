# 先に constants.rb が読まれていないとダメ
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, APP_ID, APP_SECRET, scope: 'public_profile,friends_birthday,friends_relationships,user_photos,friends_photos,xmpp_login'
end
