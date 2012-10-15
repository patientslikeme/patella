# -*- encoding: utf-8 -*-
require File.expand_path('../lib/patella/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeff Dwyer"]
  gem.email         = ["jdwyer@patientslikeme.com"]
  gem.description   = "It's Memoization into Memcached calculated in the background with Resque."
  gem.summary       = "DSL to add memoization on any method into Memcached calculated in the background with Resque."
  gem.homepage      = "https://github.com/patientslikeme/patella"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "patella"
  gem.require_paths = ["lib"]
  gem.version       = Patella::VERSION
  gem.add_dependency 'resque', '~>1.16'
  gem.add_dependency 'resque-meta', '~>1.0.0'
  gem.add_dependency 'activesupport', '>= 2.3' #, :require => 'active_support'
  gem.add_dependency 'rails', '>= 2.3' #, :require => 'active_support'
  gem.add_dependency 'json'
  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'mocha', "~>0.9.8"
  gem.add_development_dependency 'bourne'
end
