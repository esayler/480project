# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attempt do
    user_id 1
    problem_id 1
    submission "MyText"
  end
end
