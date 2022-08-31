# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    name { "#{Faker::Lorem.unique.word}_tag" }

    trait :work_tag do
      name { 'work' }
    end
  end
end
