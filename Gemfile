source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bcrypt', platforms: :ruby
gem 'bootstrap', '4.0.0'
gem 'bootswatch'
gem 'city-state'
gem 'coffee-rails', '4.2.2'
gem 'devise'
gem 'jbuilder',     '2.7.0'
gem 'jquery-rails', '4.3.1'
gem 'paper_trail'
gem 'pg', '0.20.0'
gem 'puma', '3.9.1'
gem 'rails', '5.2.0'
gem 'rails_admin', '~> 1.3.0'
gem 'rails_admin_history_rollback'
gem 'sass-rails', '5.0.6'
gem 'turbolinks', '5.0.1'
gem 'uglifier', '3.2.0'
gem 'validates_email_format_of', '1.6.3'
gem 'wdm', '>= 0.1.0' if Gem.win_platform?
gem 'will_paginate'

group :development, :test do
  gem 'byebug', '9.0.6', platform: :mri
  gem 'capybara', '~> 2.13'
  gem 'foreman'
  gem 'haml-lint', require: false
  gem 'rubocop', require: false
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'web-console',           '3.5.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
