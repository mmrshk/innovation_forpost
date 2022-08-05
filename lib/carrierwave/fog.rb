# frozen_string_literal: true

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS', # required
    aws_access_key_id: 'AKIAX3XNT6YRTBCEMZUR', # required unless using use_iam_profile
    aws_secret_access_key: '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', # required unless using use_iam_profile
    use_iam_profile: true, # optional, defaults to false
    region: 'eu-central-1', # optional, defaults to 'us-east-1'
    host: 's3.example.com', # optional, defaults to nil
    endpoint: 'https://s3.example.com:8080' # optional, defaults to nil
  }
  config.fog_directory  = 'inno-forpost--bucket-pro' # required
  config.fog_public     = false                                                 # optional, defaults to true
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
  # For an application which utilizes multiple servers but does not need caches persisted across requests,
  # uncomment the line :file instead of the default :storage.  Otherwise, it will use AWS as the temp cache store.
  # config.cache_storage = :file
end
