# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    access_token { nil }
    fb_id { [1000000000 .. 10000000000].sample.to_s }
    name { Faker::Name.name }
    birthday { [3000 .. 30000].sample.days.ago }
    gender { ['male', 'female'].sample }
    relationship_status { ['Single', 'In a Relationship', 'In an Open Relationship', 'Engaged', 'Married', 'It\'s Complicated', 'Widowed'].sample }
    picture_url { "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(Faker::Internet.email)}" }
  end
end
