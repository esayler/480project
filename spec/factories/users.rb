FactoryGirl.define do
  factory :user do
    provider "google_oauth2"
    sequence(:id) { |n| n }
    uid { Faker::Number.number(10) }
    name { Faker::Name.name }
    email { Faker::Internet.email }

    trait :admin do
      role 'admin'
    end

    trait :student do
      role 'student'
    end

    trait :alum do
      role 'alum'
    end

    trait :prof do
      role 'prof'
    end

  end
end
