FactoryGirl.define do
  factory :problem do
    user_id 1
    #sequence(:user_id) { |n| n }
    name { Faker::Lorem.word }
    language { Faker::Lorem.word }
    difficulty { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(2, false, 4) }
    time_limit 60
  end

  factory :invalid_problem, class: 'Problem' do
    name nil
  end


end
