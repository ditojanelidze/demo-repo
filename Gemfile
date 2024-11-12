source "https://rubygems.org"

ruby "3.3.5"

gem "rails", "~> 8.0.0.beta1"

gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"

gem "jbuilder"
gem "redis", "~> 5.0"
gem 'redis-rails'
gem "redis-actionpack", "~> 5.3"
gem "bootsnap", require: false
gem 'bcrypt'
gem 'phonelib'
gem 'interactor'
gem 'workflow-activerecord', '~> 6.0'
gem 'paranoia'
gem 'inline_svg'
gem 'rack-cors'
gem 'aws-sdk-s3'
gem 'kamal'
gem 'thruster'
gem 'rgeo'
gem 'rgeo-activerecord'
gem 'kaminari'

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem 'rubocop-rails'
  gem 'factory_bot_rails'
  gem 'rubocop-capybara'
  gem 'rubocop-factory_bot'
  gem 'rubocop-rspec_rails'
  gem 'dotenv'
  gem 'fakes3'
end

group :development do
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'webmock'
  gem "timecop"
  gem 'database_cleaner'
end

gem "tailwindcss-rails", "~> 2.7"
