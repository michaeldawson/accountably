ruby '2.3.1'
source 'https://rubygems.org'

gem 'rails', '~>5.0.0'

# Assets and views
gem 'jquery-rails'
gem 'turbolinks'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'haml-rails'

# Configuration
gem 'dotenv-rails', require: 'dotenv/rails-now'

# Auth
gem 'devise', github: 'plataformatec/devise' # Only until 4.2.0 is released
gem 'simple_form'

# Web scraping
gem 'capybara'
gem 'selenium-webdriver'
gem 'poltergeist', '~> 1.8'
gem 'headless'

# Background jobs
gem 'sidekiq'

group :development do
  # Style guides
  gem 'overcommit', require: false
  gem 'rubocop', require: false
  gem 'haml-lint', require: false

  # Deployment
  gem 'capistrano', '~> 3.6'
  gem 'capistrano3-env', '~> 0.1.0'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-unicorn-nginx', github: 'capistrano-plugins/capistrano-unicorn-nginx'
end

group :development, :test do
  gem 'sqlite3'
  gem 'byebug'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'zeus'
end

group :test do
  gem 'timecop'
end

group :production do
  gem 'unicorn'
  gem 'mysql2'
end
