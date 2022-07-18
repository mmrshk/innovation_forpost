FactoryBot.define do
  factory :attachment do
    name { Faker::File.file_name.split('/').last[0..20]  }
    media_file { Rack::Test::UploadedFile.new('spec/files/f.jpg', 'image/jpg') }
  end
end
