FactoryBot.define do
  factory :answer do
    ans_title  { Faker::Lorem.characters(number: 1..40) }
    ans_text   { Faker::Lorem.characters(number: 1..2000) }

    association :user
    association :consultation

    after(:build) do |answer|
      answer.ans_image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
