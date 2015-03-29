# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :problem do
    name "MyString"
    language "MyString"
    difficulty "MyString"
    pid "MyString"
    description "MyText"
    author "MyString"
  end
end
