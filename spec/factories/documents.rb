# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    name { Faker::Name.name }

    trait :with_children do
      after(:create) do |document|
        create_list(:document, 2, parent_id: document.id)
      end
    end
  end
end
