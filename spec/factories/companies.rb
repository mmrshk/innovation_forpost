# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    start_year { 2010 }
    projects_count { rand(1..100) }
    clients_count { rand(1..100) }
    grants_count { rand(1..100) }
    text_about { Faker::Lorem.characters(number: 100) }
    logo { 'f.jpg' }
    media_file { Rack::Test::UploadedFile.new('spec/files/f.jpg', 'image/jpg') }
  end

  trait :with_invalid_data do
    name { Faker::Lorem.characters(number: 101) }
    start_year { Date.today.year + 1 }
    projects_count { 0 }
    clients_count { nil }
    grants_count { -1 }
    text_about { Faker::Lorem.characters(number: 10) }
    logo { 'image' }
    media_file { Rack::Test::UploadedFile.new('spec/files/image') }
  end
end
