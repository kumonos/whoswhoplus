# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    facebook_id "MyString"
    access_token "MyString"
    name "MyString"
    birthday "2014-03-04"
    gender "MyString"
    picture_url "MyString"
  end
end
