FactoryBot.define do
  factory :review do
    point { rand(4) + 1 }

    association :user
    association :answer
  end
end
