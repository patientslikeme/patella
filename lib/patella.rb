require "patella/version"
require "patella/send_later"
require "patella/send_later_worker"
require "active_record"

module Patella
  ::Patella::SendLater.send_now = case ::Rails.env.try(:to_s)
  when 'development', 'test'
    true
  else
    false
  end
  
  ActiveRecord::Base.send :include, ::Patella::SendLater
end
