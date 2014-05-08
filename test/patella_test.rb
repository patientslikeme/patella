require 'test_helper'

class Dummy
  include Patella::SendLater

  attr_accessor :id
  def initialize id
    self.id = id
  end

  def self.find id
    new id
  end
end

class PatellaTest < ActiveSupport::TestCase
  setup do
    @dummy = Dummy.new(5)
  end
  
  teardown do
    Resque.redis.flushall
  end
  
  def test_send_now_to_instance
    assert_equal 5, @dummy.send_later(:id)
  end
  
  def test_send_now_to_class
    assert_equal 6, Dummy.send_later(:find, 6).id
  end
  
  def test_send_later_to_instance
    sending_later do
      @dummy.send_later(:id)
    end

    assert job = Resque.peek(:send_later)
    assert_equal ["Dummy", 5, "id"], job["args"]
  end
  
  def test_send_later_on_queue_to_instance
    sending_later do
      @dummy.send_later_on_queue(:unimportant, :id)
    end

    assert job = Resque.peek(:unimportant)
    assert_equal ["Dummy", 5, "id"], job["args"]
  end
  
  def test_send_later_to_class
    sending_later do
      Dummy.send_later(:find, 6)
    end
    
    assert job = Resque.peek(:send_later)
    assert_equal ["Dummy", nil, "find", 6], job["args"]
  end
  
  def test_send_later_on_queue_to_class
    sending_later do
      Dummy.send_later_on_queue(:object_finding, :find, 6)
    end
    
    assert job = Resque.peek(:object_finding)
    assert_equal ["Dummy", nil, "find", 6], job["args"]
  end

private
  def sending_later(&block)
    previous_send_now = Patella::SendLater.send_now
    begin
      Patella::SendLater.send_now = false
      yield
    ensure
      Patella::SendLater.send_now = previous_send_now
    end
  end
end
