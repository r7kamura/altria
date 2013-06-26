source "https://rubygems.org"

gem "clockwork", require: false
gem "font-awesome-rails"
gem "foreman"
gem "jquery-rails"
gem "kaminari"
gem "mysql2"
gem "puma"
gem "quiet_assets"
gem "rails", ">= 4.0.0"
gem "rails-backbone"
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
  gem "coffee-script"
  gem "sass"
  gem "sass-rails"
  gem "uglifier"
end

# Put Gemfile.local to use arbitrary gems for your use case.
workspace = ENV["WORKSPACE_PATH"] || "."
path = "#{workspace}/Gemfile.local"
eval File.read(path) if File.exist?(path)
