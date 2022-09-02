# frozen_string_literal: true

FactoryBot.define do
  factory :ck_editor_image_service do
    content_type { Rack::Test::UploadedFile.new('spec/files/pr.jpg').content_type }
    original_filename { Rack::Test::UploadedFile.new('spec/files/pr.jpg').original_filename }
    tempfile { Rack::Test::UploadedFile.new('spec/files/pr.jpg').tempfile }

    trait :invalide_file do
      content_type { Rack::Test::UploadedFile.new('spec/files/image').content_type }
      original_filename { Rack::Test::UploadedFile.new('spec/files/image').original_filename }
      tempfile { Rack::Test::UploadedFile.new('spec/files/image').tempfile }
    end
  end
end
