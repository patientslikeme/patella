require "patella/version"
require "patella/send_later"
require "patella/send_later_worker"
require "active_record"

module Patella
  rails_env = (defined?(Rails) && Rails.env)  
  ::Patella::SendLater.send_now = case rails_env
  when 'development', 'test'
    true
  else
    false
  end
  
  ActiveRecord::Base.send :include, ::Patella::SendLater
end
