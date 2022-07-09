# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    name { FFaker::Lorem.word }
  end
end
