# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "patella"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeff Dwyer"]
  s.date = "2013-06-28"
  s.description = "It's Memoization into Memcached calculated in the background with Resque."
  s.email = ["jdwyer@patientslikeme.com"]
  s.files = [".gitignore", "Gemfile", "LICENSE", "README.md", "Rakefile", "config/tddium.yml", "lib/patella.rb", "lib/patella/controllers/actions.rb", "lib/patella/helpers/patella_partial.rb", "lib/patella/patella.rb", "lib/patella/send_later.rb", "lib/patella/send_later_worker.rb", "lib/patella/version.rb", "patella.gemspec", "test/patella_test.rb", "test/test_helper.rb"]
  s.homepage = "https://github.com/patientslikeme/patella"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "DSL to add memoization on any method into Memcached calculated in the background with Resque."
  s.test_files = ["test/patella_test.rb", "test/test_helper.rb"]

  s.add_runtime_dependency(%q<resque>, ["~> 1.16"])
  s.add_runtime_dependency(%q<resque-meta>, ["~> 1.0.0"])
  s.add_runtime_dependency(%q<activesupport>, [">= 2.3"])
  s.add_runtime_dependency(%q<rails>, [">= 2.3"])
  s.add_runtime_dependency(%q<json>, [">= 0"])
  s.add_development_dependency(%q<bundler>, [">= 0"])
  s.add_development_dependency(%q<rake>, [">= 0"])
  s.add_development_dependency(%q<mocha>, ["~> 0.9.8"])
  s.add_development_dependency(%q<bourne>, [">= 0"])
  s.add_development_dependency("pry")
end
