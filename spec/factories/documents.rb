# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    name { Faker::Name.name }

    trait :with_children do
      after(:create) do |document|
        create_list(:document, 2, ancestry: document.id)
      end
    end

    trait :with_children_and_their_children do
      after(:create) do |document|
        new_document = create(:document, ancestry: document.id)
        create(:document, ancestry: new_document.id)
      end
    end
  end
end
