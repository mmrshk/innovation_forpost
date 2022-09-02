# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    phone_number { Faker::PhoneNumber.cell_phone }

    trait :admin do
      role { :admin }
    end

    trait :super_admin do
      role { :super_admin }
    end

    trait :regular_user do
      role { :user }
    end

    trait :with_random_role do
      role { User.roles.values.sample }
    end
  end
end
