require "patella/version"
require "patella/patella"
require "patella/send_later"
require "patella/send_later_worker"
require "patella/helpers/patella_partial"
require "patella/controllers/actions"

module Patella
  ActiveRecord::Base.send :include, ::Patella::SendLater
end
