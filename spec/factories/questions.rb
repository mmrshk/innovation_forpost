# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { Faker::Lorem.sentence }
    user_name { Faker::Internet.user_name }
    user_email { Faker::Internet.email }
    body { Faker::Lorem.paragraph }

    trait :question_with_invalid_email do
      title { Faker::Lorem.sentence }
      user_name { Faker::Internet.user_name }
      user_email { Faker::Lorem.characters(number: 30) } # wrong email
      body { Faker::Lorem.paragraph }
    end
  end
end
