# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }

    trait :super_admin do
      role { :super_admin }
    end

    trait :valid_params do
      password { Faker::Internet.password(min_length: 6) }
      role { :user }
    end

    trait :invalid_params do
      email { 'no_at_at_all.com' }
      password { Faker::Internet.password(max_length: 5) }
      password_confirmation { '' }
      role { :user }
    end
  end
end
