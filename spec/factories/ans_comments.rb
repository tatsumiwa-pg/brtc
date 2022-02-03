FactoryBot.define do
  factory :ans_comment do
    ans_c_text { Faker::Lorem.characters(number: 1..150) }

    association :user
    association :answer
  end
end
