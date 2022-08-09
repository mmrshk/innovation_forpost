CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                            # required
    aws_access_key_id:     Rails.application.credentials.aws[:access_key_id],            # required
    aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],            # required
    region:                'us-east-1'                       # to match the carrierwave and bucket region
  }
  config.fog_directory = Rails.application.credentials.aws[:bucket]                  # required
  config.fog_public    = false
  config.cache_dir     = "#{Rails.root}/tmp/uploads"         # To let CarrierWave work on Heroku
  config.storage       = :fog
end

