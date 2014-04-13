# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    fb_id_from "MyString"
    fb_id_to "MyString"
    message "MyText"
  end
end
