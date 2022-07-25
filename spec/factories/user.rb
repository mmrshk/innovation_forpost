# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }

    trait :role_super_admin do
      role { :super_admin }
    end

    trait :role_user do
      role { :user }
    end

    trait :valid_params do
      password { Faker::Internet.password(min_length: 6) }
      role { :user }
    end
  end
end
