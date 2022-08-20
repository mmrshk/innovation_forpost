Sidekiq.configure_client do |config|
  config.redis = { url: Rails.application.credentials.sidekiq[:redis_URL], size: 5, network_timeout: 5 }
  config.redis = { password: Rails.application.credentials.sidekiq[:redis_password] }
end

Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.credentials.sidekiq[:redis_URL], size: 5, network_timeout: 5 }
  config.redis = { password: Rails.application.credentials.sidekiq[:redis_password] }
end

schedule_file = "config/schedule.yml"

if File.exist?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end
