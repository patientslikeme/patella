require 'rubygems'
require 'bundler/setup'

module Rails
  def self.env
    'test'
  end
end

Bundler.require
require 'patella'
require 'minitest'
require 'active_support'
require 'active_support/test_case'
require 'json'
require 'mocha/setup'
require 'bourne'
require 'pry'

Minitest.autorun