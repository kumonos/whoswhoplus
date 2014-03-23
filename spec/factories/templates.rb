# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :template do
    objective { Faker::Lorem.words(3).join(' ') }
    body { Faker::Lorem.paragraphs(3).join("\n\n") }
  end
end
