require 'rubygems'
require 'bundler/setup'

module Rails
  class MockCache
    def fetch(*args)
      yield
    end
    def write(*args)
    end
  end

  def self.cache
    @cache ||= MockCache.new
  end

  def self.env
    'test'
  end
end

Bundler.require
require 'patella'
require 'test/unit'
require 'active_support'
require 'active_support/test_case'
require 'json'
require 'mocha'
require 'bourne'


