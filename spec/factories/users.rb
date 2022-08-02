# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }

    trait :admin do
      role { :admin }
    end

    trait :super_admin do
      role { :super_admin }
    end

    trait :regular_user do
      role { :user }
    end
  end
end
