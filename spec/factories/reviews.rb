FactoryBot.define do
  factory :review do
    point { rand(1..4) }

    association :answer
  end
end
