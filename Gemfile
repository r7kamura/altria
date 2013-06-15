require "pathname"

source "https://rubygems.org"

gemspec

gem "font-awesome-rails"
gem "jquery-rails"
gem "quiet_assets"
gem "resque"
gem "slim"
gem "weak_parameters"

group :development, :test do
  gem "pry-rails"
end

group :test do
  gem "autodoc"
  gem "factory_girl_rails"
  gem "response_code_matchers"
  gem "rspec-json_matcher"
  gem "rspec-rails"
  gem "simplecov"
end

group :assets do
  gem "sass-rails", "~> 3.2.3"
  gem "coffee-rails", "~> 3.2.1"
  gem "uglifier", ">= 1.0.3"
end

# Put Gemfile in plugins/:name/Gemfile to use arbitrary gems in your plugin.
Pathname.glob("plugins/*/Gemfile").each do |pathname|
  eval(pathname.read)
end
