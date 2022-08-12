require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InnovationForpost
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.exceptions_app = self.routes
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.generators do |g|
      g.test_framework :rspec
    end

    config.active_job.queue_adapter = :sidekiq
    config.i18n.available_locales = [:en, :uk]
    config.i18n.default_locale = :uk
    config.factory_bot.definition_file_paths = ["spec/factories"]
    config.action_view.sanitized_allowed_tags = %w(h1 h2 h3 h4 b i p u a div span br ul ol li em abbr blockquote hr strong strike img figure iframe oembed button length document)
    config.action_view.sanitized_allowed_attributes = %w(href target title src url height weight alt class contenteditable data-oembed-url style frameborder allowfullscreen allow)
  end
end
