# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'date_validator'
gem 'dotenv-rails'
gem 'hotwire-rails'
gem 'pg', '~> 1.1'
gem 'phony_rails'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4'
# Use Redis adapter to run Action Cable in production
# gem 'redis'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
gem 'slim-rails'
gem 'view_component', require: 'view_component/engine'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'


# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'bullet'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'selenium-webdriver', '~> 4.0.0.beta4'
  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
  gem 'faker'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers', '~> 4.0', require: !ENV['SELENIUM_URL']
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
