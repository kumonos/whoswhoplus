# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    access_token ""
    fb_id "MyString"
    name "MyString"
    birthday "2014-03-10"
    gender "MyString"
    relationship_status "MyString"
    picture_url "MyString"
  end
end
