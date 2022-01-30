FactoryBot.define do
  factory :reconciliation do
    rec_text { Faker::Lorem.characters(number: 1..40) }

    association :consultation
  end
end
