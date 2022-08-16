Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'], size: 4, network_timeout: 5 }
  config.redis = { password: Rails.application.credentials.sidekiq[:redis_password] }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'], size: 4, network_timeout: 5 }
  config.redis = { password: Rails.application.credentials.sidekiq[:redis_password] }
end

Sidekiq::Cron::Job.create(name: 'Test message every min', cron: '* * * * *', class: 'TestMailerJob') if Sidekiq.server?
