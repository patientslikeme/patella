module Patella
  class SendLaterWorker
    extend ::Resque::Plugins::Meta
    @@default_queue = :send_later
    cattr_accessor :queues
    @@queues = {}

    def self.perform_later(*args)
      # args[0] is class name of invoking class, args[2] is method
      queue = self.queue_for(args[0], args[2])
      Resque::Job.create(queue, 'Patella::SendLaterWorker', *args)
    end

    def self.queue_for(class_name, method_name)
      @@queues[class_name.to_s].try(:[],method_name.to_s) || @@default_queue
    end

    def self.perform(class_name, instance_id, method_name, *args)
      o = class_name.constantize
      o = o.find_by_id instance_id if instance_id

      o.send(method_name, *args)
    rescue => e
      raise e, "#{e.message} \nWith SendLater: #{class_name}#{':'+instance_id.to_s if instance_id}##{method_name}(#{args.map(&:to_s).join(',')})", e.backtrace
    end
  end
end