# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    body { Faker::Lorem.paragraph }

    trait :with_question do
      question_id { create :question }
    end

    trait :invalid_answer do
      body { Faker::Lorem.characters(number: 1) }
    end
  end
end
