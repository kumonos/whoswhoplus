FactoryGirl.define do
  factory :message do
    fb_id_from { Random.rand(1000000000 .. 10000000000).to_s }
    fb_id_to { Random.rand(1000000000 .. 10000000000).to_s }
    fb_id_target { Random.rand(1000000000 .. 10000000000).to_s }
    message { Faker::Lorem.paragraph }
  end
end
