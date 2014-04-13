source 'https://rubygems.org'

gem 'rails', '4.0.3'

# Facebook API
gem 'koala', "~>1.8.0rc1"
gem 'facebook_chat'

# Views
gem 'haml-rails'

# Assets
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'therubyracer'

group :development do
  # Debugging
  gem 'better_errors'
  gem 'binding_of_caller'

  # CLI Tools
  gem 'erb2haml'
  gem 'rspec-kickstarter'
end

group :test do
  # Specs
  gem 'rspec-rails', '~> 3.0.0.beta2'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :development, :test do
  # Debugging
  gem 'byebug'

  # Database
  gem 'sqlite3'
end

group :production do
  # AP Server
  # gem 'unicorn'
  gem 'pg'
end
