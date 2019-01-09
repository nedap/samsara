# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'samsara/version'

Gem::Specification.new do |spec|
  spec.name          = "samsara"
  spec.version       = Samsara::VERSION
  spec.authors       = ["Tom Nijmeijer"]
  spec.email         = ["tom.nijmeijer@nedap.com"]
  spec.summary       = "Custom auditing gem made for and by Staffing Solutions"
  spec.description   = <<-DESC
    Custom auditing gem made for and by Staffing Solutions. Rather than just saving the modifications made,
    this gem puts the changes in context by storing a separate context object. Multiple
    revisions can be attached to a single context such as a single http request.
  DESC
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord",  ">= 5.0"
  spec.add_dependency "activesupport", ">= 5.0"
  spec.add_dependency "activestorage", ">= 5.0"

  spec.add_development_dependency "bundler", ">= 1.6"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_development_dependency "rspec-rails", "~> 3.7"
end
