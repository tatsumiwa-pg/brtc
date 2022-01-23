FactoryBot.define do
  factory :consultation do
    cons_title  { Faker::Lorem.characters(number: 1..50) }
    category_id { Faker::Number.between(from: 1, to: 26) }
    summary     { Faker::Lorem.characters(number: 1..150) }
    situation   { Faker::Lorem.characters(number: 1..2000) }
    problem     { Faker::Lorem.characters(number: 1..2000) }

    association :user

    after(:build) do |consultation|
      consultation.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
