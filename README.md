# Patella

Patella is a robust implementation of send_later for Rails applications using Resque.  It supports:

* Sending to specific queues on a per-call basis
* A global on/off switch for send_later
* Sensible defaults for the default Rails environments (send_later is disabled in development and test)

# What happened to memoization into memcached etc?

Patella was originally a gem for memoizing expensive method calls in Rails apps in the background and loading them
asynchronously.  Jeff Dwyer did a RailsConf 2012 talk about it: [www.slideshare.net/jdwyah/patella-railsconf-2012](http://www.slideshare.net/jdwyah/patella-railsconf-2012)

## Installation

Add this line to your application's Gemfile:

    gem 'patella'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install patella

## Usage

```ruby
post = Post.find(params[:id])
post.send_later(:slow_calculation)
post.send_later(:slow_calculation_with_two_parameters, 5, "jdwyah!")
post.send_later_on_queue(:hashing, :hash_content, 8675309)

Post.send_later(:class_method)
Post.send_later_on_queue(:high_priority, :class_method_with_a_parameter, 50)
```

`Patella::SendLater` is the module that provides the `send_later` and `send_later_on_queue` methods.  It's included by default
in all `ActiveRecord::Base` subclasses, but you can include it in any class that implements the `#id` and `.find` methods.

By default, `send_later` will enqueue jobs on a queue called "send_later".  You can alter this default:

```ruby
Patella::SendLaterWorker.default_queue = :my_custom_queue
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
