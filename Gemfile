ruby '2.3.1'
source 'https://rubygems.org'

gem 'rails', '4.2.6'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'haml-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'devise', github: 'plataformatec/devise' # Only until 4.2.0 is released
gem 'simple_form'
gem 'sdoc', '~> 0.4.0', group: :doc

group :development, :test do
  gem 'sqlite3'
  gem 'byebug'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'zeus'
end

group :development do
  gem 'overcommit', require: false
  gem 'rubocop', require: false
end

group :production do
  gem 'puma'
  gem 'pg'
end
