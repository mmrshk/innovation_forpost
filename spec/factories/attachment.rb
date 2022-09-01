# frozen_string_literal: true

FactoryBot.define do
  factory :attachment do
    name { 'fake_image.png' }
    media_file { Rack::Test::UploadedFile.new('spec/files/f.jpg', 'image/jpg') }
  end
end
