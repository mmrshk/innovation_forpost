# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'

gem 'pg'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.5'

gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

gem 'jbuilder', '~> 2.7'
gem 'rails-i18n', '~> 6.0'

gem 'devise', '~> 4.8', '>= 4.8.1'

gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'pry', '~> 0.14.1'
  gem 'rspec-rails'
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
  gem 'shoulda-matchers', '~> 5.0'
  gem 'webdrivers'
end
