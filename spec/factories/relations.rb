# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :relation do
    friend_friend "MyString"
    friend_mutual "MyString"
    profile ""
  end
end
