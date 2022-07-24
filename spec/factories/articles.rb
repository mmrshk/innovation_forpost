# frozen_string_literal: true

FactoryBot.automatically_define_enum_traits = false

FactoryBot.define do
  factory :article do
    title { Faker::Lorem.characters(number: 20) }
    text { Faker::Lorem.characters(number: 100) }
    user_id { (create :user).id }
    tags { create_list(:tag, 2) }

    traits_for_enum(:status, %w[draft published trashed])
    traits_for_enum(:language, %w[uk en])

    trait :invalid_article do
      title { Faker::Lorem.characters(number: 101) }
      text { '' }
      user_id { nil }
      status { nil }
      language { nil }
    end
  end
end
