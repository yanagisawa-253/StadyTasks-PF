FactoryBot.define do
  factory :inquiry do
    name { Faker::Lorem.characters(number:5) }
    sequence(:email) { |n| "hiro#{n}@example.com"}
    message { Faker::Lorem.characters(number:20) }
  end
end