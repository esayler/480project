# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attempt do
    user_id 1
    #sequence(:user_id) { |n| n }
    sequence(:problem_id) { |n| n }
    submission { Faker::Hacker.say_something_smart }
  end

  factory :invalid_attempt, class: 'Attempt' do
    #user_id nil
    submission nil
  end
end
