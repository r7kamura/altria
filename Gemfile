require "pathname"

source "https://rubygems.org"

gem "clockwork"
gem "font-awesome-rails"
gem "foreman"
gem "jquery-rails"
gem "kaminari"
gem "mysql2"
gem "puma"
gem "quiet_assets"
gem "rails", ">= 4.0.0"
gem "rake"
gem "redis"
gem "resque"
gem "slim"
gem "weak_parameters"

group :development, :test do
  gem "pry-rails"
end

group :test do
  gem "autodoc"
  gem "coveralls", require: false
  gem "factory_girl_rails"
  gem "response_code_matchers"
  gem "rspec-json_matcher"
  gem "rspec-rails"
  gem "simplecov"
end

group :assets do
  gem "coffee-rails"
  gem "sass-rails"
  gem "uglifier"
end

group :production do
  gem "therubyracer"
end

# Put Gemfile.local to use arbitrary gems for your use case.
path = Pathname.new("Gemfile.local")
eval(path.read) if path.exist?
