FactoryBot.define do
  factory :profile do
    age_id         { Faker::Number.between(from: 1, to: 6) }
    job            { Faker::Lorem.characters(number: 1..100) }
    skills         { Faker::Lorem.characters(number: 1..200) }
    address        { Faker::Lorem.characters(number: 1..50) }
    cat_exp        { Faker::Lorem.characters(number: 1..200) }
    family_type_id { Faker::Number.between(from: 1, to: 6) }
    house_env_id   { Faker::Number.between(from: 1, to: 7) }
    my_cats        { Faker::Lorem.characters(number: 1..500) }
    introduction   { Faker::Lorem.characters(number: 1..1000) }

    association :user

    after(:build) do |profile|
      profile.user_image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
