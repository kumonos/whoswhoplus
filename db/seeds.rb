require 'factory_girl'
Dir[Rails.root.join('spec/factories/*.rb')].each { |f| require f }

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
