source 'https://rubygems.org'
ruby "1.9.3"

gem 'rails'
gem 'bootstrap-sass', '~> 2.3.1.0'
gem 'jquery-rails'
gem 'omniauth-twitter'
gem 'omniauth-facebook', '1.4.0'
gem 'paperclip', '~> 3.0'
gem 'aws-sdk'
gem 'will_paginate', '~> 3.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
  #gem 'sqlite3', '1.3.5'
  gem 'pg', '0.12.2'
  gem 'rspec-rails', '2.10.0'
  gem 'guard-rspec', '0.5.5'
end

group :development do
  gem 'annotate' 
  gem 'mailcatcher'
  gem 'better_errors'
  gem 'binding_of_caller'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2'
  gem 'coffee-rails', '3.2.2'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '1.2.3'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'rb-inotify', '0.8.8'
  gem 'libnotify', '0.5.9'
  gem 'guard-spork', '0.3.2'
  gem 'spork', '0.9.0'
  gem 'factory_girl_rails', '1.4.0'
end

group :production do
  gem 'pg', '0.12.2'
  gem 'thin'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
