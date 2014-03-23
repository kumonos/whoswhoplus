#require 'active_support'
require 'faker'
require 'factory_girl'
Dir[Rails.root.join('spec/factories/*.rb')].each { |f| require f }

# DBクリア
AccessToken.delete_all
Profile.delete_all
Relation.delete_all
Template.delete_all

# Profile作成
p1 = FactoryGirl.create(:profile)
p2 = FactoryGirl.create(:profile)
p3 = FactoryGirl.create(:profile)
p4 = FactoryGirl.create(:profile)
p5 = FactoryGirl.create(:profile)

# 適当に友達関係を結ぶ
# 1が認証ユーザ
# 1と2, 1と3が友達
# 2と4, 2と5が友達
# 3と4が友達
FactoryGirl.create(:relation, friend_friend: p4.fb_id, friend_mutual: p2.fb_id, profile: p1)
FactoryGirl.create(:relation, friend_friend: p5.fb_id, friend_mutual: p2.fb_id, profile: p1)
FactoryGirl.create(:relation, friend_friend: p4.fb_id, friend_mutual: p3.fb_id, profile: p1)

# テンプレート投入
Template.create(
  objective: '3人で飲みに行きたい',
  body: '3人で飲みに行きませんか？'
)
Template.create(
  objective: 'どんな子か知りたい',
  body: '彼氏はいるんですか？'
)
Template.create(
  objective: '連絡先を教えてほしい',
  body: 'LINEおしえて！'
)
