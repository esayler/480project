# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "google_oauth2"
    uid { Faker::Number.number(10) }
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end
end
