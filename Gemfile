source 'https://rubygems.org'

gem 'dotenv-rails', :groups => [:development, :test]

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.2'
ruby '2.1.2'

# Use postgresql as the database for Active Record
gem 'pg'
gem 'thin'
gem 'high_voltage'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem "font-awesome-rails"

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem "passenger"
gem 'slim-rails'
gem 'rails_12factor', group: :production
gem 'compass-rails'
gem 'postmarkdown', github: "jess/postmarkdown", branch: "production"
gem 'rack-canonical-host'
gem 'foundation-rails'
gem 'rack-rewrite'
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'

group :development do
  gem 'rack-livereload'
  gem 'guard-livereload'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'pry-rails'
end
