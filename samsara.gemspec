# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'samsara/version'

Gem::Specification.new do |spec|
  spec.name          = "samsara"
  spec.version       = Samsara::VERSION
  spec.authors       = ["Tom Nijmeijer"]
  spec.email         = ["tom@nijmeijer.org"]
  spec.summary       = "Custom auditing gem made for and by PEP"
  spec.description   = <<-DESC
    Custom auditing gem made for and by PEP. Rather than just saving the modifications made,
    this gem puts the changes in context by recording a separate context object. Multiple
    modifications can be attached to a single context such as a single http request.
  DESC
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord",  ">= 3.0"
  spec.add_dependency "activesupport", ">= 3.0"

  spec.add_development_dependency "bundler", ">= 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "sqlite3", "~> 1.2"
  spec.add_development_dependency "rspec-rails", "~> 3.2"
end
