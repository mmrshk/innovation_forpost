# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    name { Faker::Name.name }
  end
end
