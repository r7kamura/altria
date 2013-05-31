lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "magi/version"

Gem::Specification.new do |spec|
  spec.name          = "magi"
  spec.version       = Magi::VERSION
  spec.authors       = ["Ryo Nakamura"]
  spec.email         = ["r7kamura@gmail.com"]
  spec.description   = "I am Magi."
  spec.summary       = "Magi"
  spec.homepage      = "https://github.com/r7kamura/magi"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "coffee-rails", "~> 3.2.1"
  spec.add_dependency "jquery-rails"
  spec.add_dependency "mysql2"
  spec.add_dependency "rails", "3.2.13"
  spec.add_dependency "sass-rails",   "~> 3.2.3"
  spec.add_dependency "sidekiq"
  spec.add_dependency "uglifier", ">= 1.0.3"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-rails"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails"
end
