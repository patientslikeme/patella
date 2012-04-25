require 'test_helper'

class Dummy
  include Patella::Patella
  include Patella::SendLater

  attr_accessor :id
  def initialize id
    self.id = id
  end

  def self.find_by_id id
    new id
  end

  def foo
    5
  end
  patella_reflex :foo

  def bar(a,b)
    a+b
  end
  patella_reflex :bar

  def baz(add)
    self.id + add
  end
  patella_reflex :baz

  def self.bing
    3
  end
  patella_reflex :bing, :class_method => true

  def no_background_add(a,b)
    a + b
  end
  patella_reflex :no_background_add, :no_backgrounding => true
end

class PatellaTest < ActiveSupport::TestCase

  def test_patella_basics
    # foreground
    f = Dummy.new 6
    f.stubs :caching_foo => 5
    assert_equal 5, f.foo
    assert_received(f, :caching_foo)

    #background
    with_caching do
      Patella::SendLaterWorker.stubs :perform_later => 'loading'
      f1 = Dummy.new 5
      assert f1.foo.loading?
      assert_received(Patella::SendLaterWorker, :perform_later) do |ex|
        ex.once
        ex.with 'Dummy', f1.id, :caching_foo, []
      end
    end
  end

  def test_turning_off_background
    #background
    with_caching do
      Patella::SendLaterWorker.expects(:perform_later).never
      Dummy.any_instance.expects('caching_no_background_add').once.returns(9)
      d = Dummy.new(1)
      result = d.no_background_add(4,5)
      assert result.loaded?
      assert_equal 9, result
    end
  end

  def cache_clearing
    d = Dummy.new(1)
    result = d.bar(4,5)  #load it by turning caching off
    assert result.loaded?
    assert_equal 9, result

    with_caching do
      result = d.bar(4,5)  #still here
      assert result.loaded?
      assert_equal 9, result

      d.clear_bar(4,5)
      result = d.bar(4,5)  #cleared
      assert result.loading?

    end
  end

  def test_patella_for_instance_objs
    four = Dummy.new 4
    assert_equal(8, four.baz(4))
    assert_equal(13, four.baz(9))
  end

  def test_patella_for_class_methods
    assert Dummy.bing.loaded?
    assert_equal(3, Dummy.bing)
  end

  def test_keys
    d = Dummy.new 2
    assert_equal "patella/Dummy/2/foo/#{md5 [].to_json}", d.patella_key(:foo,[])
    assert_equal "patella/Dummy/2/foo/#{md5 [1].to_json}", d.patella_key(:foo,[1])
    assert_equal "patella/Dummy/2/foo/#{md5 [1,3].to_json}", d.patella_key(:foo,[1,3])
    assert_equal "patella/Dummy/2/foo/#{md5 [1,"asdf"].to_json}", d.patella_key(:foo,[1,"asdf"])
    assert_equal "patella/Dummy/2/foo/#{md5 [1,"asdf"*1000].to_json}", d.patella_key(:foo,[1, ("asdf"*1000)])

    d3 = Dummy.new 3
    assert_equal "patella/Dummy/3/foo/#{md5 [].to_json}", d3.patella_key(:foo,[])
    assert_equal "patella/Dummy/3/foo/#{md5 [1].to_json}", d3.patella_key(:foo,[1])
    assert_equal "patella/Dummy/3/foo/#{md5 [1,3].to_json}", d3.patella_key(:foo,[1,3])
    assert_equal "patella/Dummy/3/foo/#{md5 [1,"asdf" * 1000].to_json}", d3.patella_key(:foo,[1,"asdf" * 1000])
  end

  def test_soft_expiration
    dummy = Dummy.new 1
    ::Rails.cache.stubs( :fetch => { 'result' => "loads of data", 'soft_expiration' => Time.now-1.minute }.to_json )
    ::Rails.cache.stubs( :write => true )
    dummy.stubs :send_later => 'loading'
    dummy.foo
    assert_received(Rails.cache, :write) { |ex| ex.once }
    assert_received(dummy, :send_later) { |ex| ex.once }
  end

private
  def md5(str)
    Digest::MD5.hexdigest(str)
  end

  def with_caching(&block)
    #previous_caching = ActionController::Base.perform_caching
    begin
      Rails.stubs(:caching? => true)
      #ActionController::Base.perform_caching = true
      yield
    ensure
      #ActionController::Base.perform_caching = previous_caching
    end
  end
end
