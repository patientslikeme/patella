# -*- encoding: utf-8 -*-
require File.expand_path('../lib/patella/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeff Dwyer", "Nat Budin"]
  gem.email         = ["jdwyer@patientslikeme.com", "nbudin@patientslikeme.com"]
  gem.description   = "A robust implementation of send_later for Rails apps using Resque."
  gem.summary       = <<-EOF
  Patella provides an ActiveRecord-friendly send_later implementation for Resque that allows sending
  to specific queues as well as a global on/off switch for send_later, and sensible defaults for
  the default Rails environments.
  EOF
  gem.homepage      = "https://github.com/patientslikeme/patella"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "patella"
  gem.require_paths = ["lib"]
  gem.version       = Patella::VERSION
  gem.add_dependency 'resque', '~>1.16'
  gem.add_dependency 'resque-meta', '~>1.0.0'
  gem.add_dependency 'rails', '>= 2.3'
  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'mocha', ">= 0.9.8"
  gem.add_development_dependency 'bourne'
  gem.add_development_dependency 'pry'
end
