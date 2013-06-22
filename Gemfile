require "pathname"

source "https://rubygems.org"

gemspec

gem "font-awesome-rails"
gem "jquery-rails"
gem "kaminari"
gem "quiet_assets"
gem "rails-backbone"
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
  gem "sass-rails"
  gem "coffee-rails"
  gem "uglifier"
end

# Put Gemfile.local to use arbitrary gems for your use case.
eval File.read("Gemfile.local") if File.exist?("Gemfile.local")
