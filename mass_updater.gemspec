# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mass_updater/version'

Gem::Specification.new do |spec|
  spec.name          = "mass_updater"
  spec.version       = MassUpdater::VERSION
  spec.authors       = ["Michael Schneider"]
  spec.email         = ["michael.schneider@adtegrity.com"]
  spec.summary       = %q{Bulk updating and inserting of records for ActiveRecord and mysql}
  spec.description   = %q{This gem can reduce rounds trips between your app and the database from thousands down to a single query}
  spec.homepage      = "https://github.com/KarateCode/mass_updater"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'mysql2'
  spec.add_development_dependency "activerecord", "~> 3.2"
end
