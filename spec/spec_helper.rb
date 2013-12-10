require "simplecov"
require "coveralls"
Coveralls.wear!
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter,
]
SimpleCov.start

ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "rspec/autorun"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus
  config.infer_base_class_for_anonymous_controllers = false
  config.run_all_when_everything_filtered = true
  config.use_transactional_fixtures = true

  config.include RSpec::JsonMatcher, type: :request
  config.include ResponseCodeMatchers, type: :request

  config.before(:suite) do
    Altria.configuration.workspace_path = Rails.root.join("tmp/workspace")
  end

  config.after(:suite) do
    workspace = Rails.root.join("tmp/workspace")
    workspace.rmtree if workspace.exist?
  end

  config.before do
    $redis.stub(:publish)
  end
end

Resque.inline = true

Autodoc.configuration.path = "doc/api"
Autodoc.configuration.toc = true
