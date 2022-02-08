FactoryBot.define do
  factory :review do
    point { rand(1..4) }

    association :user
    association :answer
  end
end
