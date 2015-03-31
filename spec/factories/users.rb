# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "google_oauth2"
    uid "12345"
    name "testdude"
    email "user@example.com"
  end
end
