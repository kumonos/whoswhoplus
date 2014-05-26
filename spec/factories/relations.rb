# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :relation do
    fb_id_from { Random.rand(1000000000 .. 5000000000).to_s }
    fb_id_to { Random.rand(5000000000 .. 10000000000).to_s }
  end
end
