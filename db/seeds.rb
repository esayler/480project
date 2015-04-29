# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#

50.times do
  Problem.create({name: Faker::App.name,
                 language: "python",
                 description: Faker::Hacker.say_something_smart,
                 difficulty: 1,
                 user_id: 1})
end





