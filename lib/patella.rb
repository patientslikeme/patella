require "patella/version"
require "patella/patella"
require "patella/send_later"
require "patella/send_later_worker"

module Patella
  ActiveRecord::Base.send :include, ::Patella::SendLater
end
