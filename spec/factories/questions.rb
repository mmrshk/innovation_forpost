# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { Faker::Lorem.sentence }
    user_name { Faker::Internet.user_name }
    user_email { Faker::Internet.email }
    body { Faker::Lorem.paragraph }

    trait :invalid_question do
      title { Faker::Lorem.characters(number: 1) }
      body { Faker::Lorem.characters(number: 1) }
      user_name { Faker::Lorem.characters(number: 1) }
      user_email { Faker::Lorem.characters(number: 256) }
    end
  end
end
