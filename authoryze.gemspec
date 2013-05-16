# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'authoryze/version'

Gem::Specification.new do |spec|
  spec.name          = "authoryze"
  spec.version       = Authoryze::VERSION
  spec.authors       = ["Maher Hawash"]
  spec.email         = ["gmhawash@gmail.com"]
  spec.description   = %q{Provides matrix based and role level authorization}
  spec.summary       = %q{matrix based and role level authorization}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'watchr'
  spec.add_development_dependency 'debugger'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'simplecov'
end
