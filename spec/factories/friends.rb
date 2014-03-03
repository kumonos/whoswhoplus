# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :friend do
    from_facebook_id "MyString"
    to_facebook_id "MyString"
  end
end
