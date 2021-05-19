source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.6'
gem 'pg', '~> 0.18.1'
gem 'puma', '~> 4.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'omniauth-google-oauth2', '~> 0.2.1'
gem 'bootstrap-sass', '~> 3.3.7'
gem 'jquery-rails'
gem 'google_drive'
gem 'has_scope'
gem 'will_paginate', '~> 3.1.0'
gem 'will_paginate-bootstrap'
gem 'bundle-audit'
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'


group :development, :test do

  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'factory_bot_rails'
  gem 'ngrok-tunnel'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'capistrano', '~> 3.6', '>= 3.6.1'
  gem 'capistrano-rvm', '~> 0.1.2'
  gem 'capistrano-rails', '~> 1.1', '>= 1.1.8'
  gem 'capistrano-faster-assets', '~> 1.0', '>= 1.0.2'

end

group :development do

  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
