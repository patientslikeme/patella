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

require 'active_support/core_ext'

Bundler.require
require 'patella'
require 'test/unit'
require 'active_support/test_case'
require 'json'
require 'mocha'
require 'bourne'
require 'pry'

