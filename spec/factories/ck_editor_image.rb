# frozen_string_literal: true

FactoryBot.define do
  factory :ck_editor_image do
    file { Rack::Test::UploadedFile.new('spec/files/pr.jpg') }

    trait :with_article do
      article_id { :article }
    end

    trait :invalid_ck_editor_image do
      file { Rack::Test::UploadedFile.new('spec/files/image') }
    end
  end
end
