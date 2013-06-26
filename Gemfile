source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'unicorn'
gem 'pg'

group :assets do
  gem 'sass-rails', '~> 4.0.0'
  gem 'uglifier' # compressor for JavaScript assets
  gem 'coffee-rails', '~> 4.0.0'
end

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
gem 'ember-rails'
gem 'jbuilder'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby'

# gem 'devise'
# gem 'twitter'
# gem 'highcharts-rails'

group :development do
  gem 'rack-mini-profiler'
end

group :test do
  gem 'mocha', :require => 'mocha/api'
end

group :production do
  gem 'rails_12factor' # Heroku requirement
end
