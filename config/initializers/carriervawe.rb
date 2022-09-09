if !Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     Rails.application.credentials[Rails.env.to_sym][:aws][:access_key_id],
      aws_secret_access_key: Rails.application.credentials[Rails.env.to_sym][:aws][:secret_access_key],
      region:                Rails.application.credentials[Rails.env.to_sym][:aws][:region]
    }
    config.fog_directory = Rails.application.credentials[Rails.env.to_sym][:aws][:bucket]
    config.fog_public    = true
    config.cache_dir     = "#{Rails.root}/tmp/uploads"
    config.storage       = :fog
  end
end
