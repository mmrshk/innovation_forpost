if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     Rails.application.credentials.aws[:access_key_id],
      aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
      region:                Rails.application.credentials.aws[:region]
    }
    config.fog_directory = Rails.application.credentials.aws[:bucket]
    config.fog_public    = false
    config.cache_dir     = "#{Rails.root}/tmp/uploads"
    config.storage       = :fog
  end
end
