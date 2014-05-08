require 'resque'
require 'resque/plugins/meta'

module Patella
  class SendLaterWorker
    extend ::Resque::Plugins::Meta
    cattr_accessor :default_queue
    self.default_queue = :send_later

    def self.perform_later(class_name, instance_id, method_name, *args)
      perform_later_on_queue default_queue, class_name, instance_id, method_name, *args
    end
    
    def self.perform_later_on_queue(queue, class_name, instance_id, method_name, *args)
      Resque::Job.create(queue, 'Patella::SendLaterWorker', class_name, instance_id, method_name, *args)      
    end

    def self.perform(class_name, instance_id, method_name, *args)
      o = class_name.constantize
      o = o.find(instance_id) if instance_id

      o.send(method_name, *args)
    rescue => e
      raise e, "#{e.message} \nWith SendLater: #{class_name}#{':'+instance_id.to_s if instance_id}##{method_name}(#{args.map(&:to_s).join(',')})", e.backtrace
    end
  end
end
