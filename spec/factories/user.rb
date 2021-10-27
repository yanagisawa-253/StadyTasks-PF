FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number:3) }
    introduction { Faker::Lorem.characters(number:20) }
    sequence(:email) { |n| "hiro#{n}@example.com"}
    password { Faker::Lorem.characters(number:6) }
  end
end