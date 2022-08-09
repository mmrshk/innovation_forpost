# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'
gem 'rails', '~> 6.0.5'

gem 'active_storage_validations'
gem 'ancestry', '~> 4.2'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'carrierwave', '~> 2.2.2'
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'factory_bot_rails', '~> 6.2.0'
gem 'fog-aws', '~> 3.14.0'
gem 'font-awesome-rails', '>= 4.7'
gem 'jbuilder', '~> 2.7'
gem 'materialize-sass', '~> 1.0.0'
gem 'mini_magick'
gem 'new_ckeditor', '~> 0.1.2'
gem 'pg', '~> 1.4.1'
gem 'puma', '~> 4.1'
gem 'rails-i18n', '~> 6.0'
gem 'redis', '~> 4.0'
gem 'sass-rails', '>= 6'
gem 'simple_form', '~> 5.1'
gem 'turbo-rails', '~> 1.1', '>= 1.1.1'
gem 'webpacker', '~> 4.0'

group :production, :development do
  gem 'lit', '~> 1.1.6'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'faker', '~> 2'
  gem 'pry', '~> 0.14.1'
  gem 'rails-controller-testing', '~> 1.0.5'
  gem 'rspec-rails', '~> 5.1.2'
end

group :development do
  gem 'brakeman', '~> 5.2.3', require: false
  gem 'listen', '~> 3.2'
  gem 'overcommit', '~> 0.59.1'
  gem 'rails_best_practices', '~> 1.23.1'
  gem 'rubocop', '~> 1.31.1', require: false
  gem 'spring', '~> 2.1.1'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver', '~> 4.3.0'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', require: false
  gem 'webdrivers', '~> 5.0.0'
end
