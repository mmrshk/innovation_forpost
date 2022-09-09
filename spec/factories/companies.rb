# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    start_year { rand(2000..Date.today.year) }
    projects_count { rand(1..100) }
    clients_count { rand(1..100) }
    grants_count { rand(1..100) }
    text_about { Faker::Lorem.sentences(number: 10).join }
    media_file { Rack::Test::UploadedFile.new('spec/files/f.jpg', 'image/jpg') }

    traits_for_enum(:language, Company::LANGUAGES.keys)

    trait :with_random_language do
      language { Company::LANGUAGES.keys.sample }
    end
  end

  trait :with_invalid_data do
    name { Faker::Lorem.characters(number: 101) }
    start_year { Date.today.year + 1 }
    projects_count { 0 }
    clients_count { nil }
    grants_count { -1 }
    text_about { Faker::Lorem.characters(number: 10) }
    media_file { Rack::Test::UploadedFile.new('spec/files/image') }
    language { Company::LANGUAGES.keys.sample }
  end
end
