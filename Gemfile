source 'https://rubygems.org'

gem 'rails', '4.0.5'

# Facebook API
gem 'omniauth-facebook'
gem 'koala', "~>1.8.0rc1"
gem 'facebook_chat'

# Views
gem 'haml-rails'

# Assets
gem 'sass-rails'
gem 'less-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'therubyracer'
gem 'cloudinary'
gem 'resque'

group :development do
  # Debugging
  gem 'better_errors'
  gem 'binding_of_caller'

  # CLI Tools
  gem 'erb2haml'
  gem 'rspec-kickstarter'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  # Specs
  # rc1 にすると have が使えない？　のでひとまず beta2 固定
  gem 'rspec-rails', '3.0.0.beta2'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :development, :test do
  # Debugging
  gem 'pry-byebug'

  # Database
  gem 'sqlite3'
end

group :staging, :production do
  # AP Server
  gem 'unicorn'
  gem 'execjs'

  # Database
  gem 'mysql2'
end
