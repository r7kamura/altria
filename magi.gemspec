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

  spec.files         = Dir["{app,bin,config,db,lib,plugins,public,script,spec}/**/*"]
  spec.files         += %w[
                          Gemfile
                          LICENSE.txt
                          Procfile
                          README.md
                          Rakefile
                          config.ru
                          magi.gemspec
                        ]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "clockwork"
  spec.add_dependency "coffee-rails", ">= 4.0.0"
  spec.add_dependency "font-awesome-rails"
  spec.add_dependency "foreman"
  spec.add_dependency "jquery-rails"
  spec.add_dependency "kaminari"
  spec.add_dependency "mysql2"
  spec.add_dependency "quiet_assets"
  spec.add_dependency "rails", ">= 4.0.0.rc2"
  spec.add_dependency "rake"
  spec.add_dependency "resque"
  spec.add_dependency "sass-rails", ">= 4.0.0.rc1"
  spec.add_dependency "slim"
  spec.add_dependency "uglifier", ">= 1.3.0"
  spec.add_dependency "weak_parameters"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "pry-rails"
  spec.add_development_dependency "thin"
end
