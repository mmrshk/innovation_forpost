# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'

gem 'pg'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.5'

gem 'materialize-sass', '~> 1.0.0'
gem 'redis', '~> 4.0'
gem 'sass-rails', '>= 6'
gem 'simple_form', '~> 5.1'
gem 'turbo-rails', '~> 1.1', '>= 1.1.1'
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'active_storage_validations'
gem 'jbuilder', '~> 2.7'
gem 'mini_magick'
gem 'rails-i18n', '~> 6.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'jbuilder', '~> 2.7'
gem 'rails-i18n', '~> 6.0'

gem 'bootsnap', '>= 1.4.2', require: false

gem 'lit', '~> 1.1.6'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'faker', '~> 2'
  gem 'pry', '~> 0.14.1'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'web-console', '>= 3.3.0'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'brakeman', '~> 5.2.3', require: false
  gem 'overcommit', '~> 0.59.1'
  gem 'rails_best_practices', '~> 1.23.1'
  gem 'rubocop', '~> 1.31.1', require: false
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'shoulda-matchers', '~> 5.0'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'font-awesome-rails'
