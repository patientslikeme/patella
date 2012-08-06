module Patella::SendLater

  # If send_now is true, Object.send_later will run the command in-process rather than
  # putting it on the queue.
  mattr_accessor :send_now

  def self.included(base)
    base.extend ClassMethods
  end

  def send_later method_name, *args
    if ::Patella::SendLater.send_now      
      self.send method_name, *args
    else
      Patella::SendLaterWorker.perform_later self.class.to_s, self.id, method_name, *args
    end
  end

  module ClassMethods
    def send_later method_name, *args
      if ::Patella::SendLater.send_now
        self.send method_name, *args
      else
        Patella::SendLaterWorker.perform_later self.to_s, nil, method_name, *args
      end
    end
  end

end
