FactoryBot.define do
  factory :task do
    title { Faker::Lorem.characters(number:20) }
    body { Faker::Lorem.characters(number:50) }
  end
end
