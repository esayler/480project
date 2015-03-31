# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :problem do
    name "problem_name"
    language "python"
    difficulty "easy"
    pid "0001"
    description "Hello, World!"
    author "Professor X"
  end
end
