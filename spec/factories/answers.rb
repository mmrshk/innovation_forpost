# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    body { Faker::Lorem.paragraph }
    association :question

    trait :invalid_answer do
      body { Faker::Lorem.characters(number: 1) }
    end
  end
end
