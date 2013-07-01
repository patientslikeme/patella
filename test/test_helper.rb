require 'rubygems'
require 'bundler/setup'

module Rails
  def self.cache
    @cache ||= ActiveSupport::Cache::MemoryStore.new
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


