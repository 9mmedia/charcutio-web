source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'unicorn'
gem 'pg'

gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier' # compressor for JavaScript assets

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
gem 'ember-rails'
gem 'ember-auth-rails'
gem 'jbuilder'

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'active_model_serializers'

# gem 'devise'
# gem 'twitter'
# gem 'highcharts-rails'

group :development do
  gem 'rack-mini-profiler'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'mocha', require: 'mocha/api'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'json_spec'
  gem 'qunit-rails'
end

group :production do
  gem 'rails_12factor' # Heroku requirement
  gem 'newrelic_rpm'
end
