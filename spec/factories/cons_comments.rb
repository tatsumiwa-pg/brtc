FactoryBot.define do
  factory :cons_comment do
    cons_c_text { Faker::Lorem.characters(number: 1..150) }

    association :user
    association :consultation
  end
end
