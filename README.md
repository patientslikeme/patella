# Patella

Gem for the RailsConf 2012 talk Patella: It's Memoization into Memcached calculated in the background with Resque.
[www.slideshare.net/jdwyah/patella-railsconf-2012](http://www.slideshare.net/jdwyah/patella-railsconf-2012)

## Installation

Add this line to your application's Gemfile:

    gem 'patella'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install patella

## Usage

```ruby
  def self.my_slow_method(user_id)
    all_notifications_for(User.find(user_id))
  end
  patella_reflex :notification_unread_count, :expires_in => 3.minutes, :class_method => true
```

See the tests for more [examples](https://github.com/kbrock/patella/blob/master/test/patella_test.rb)

Inlcude the partial:
```ruby
  module ApplicationHelper
    include Patella::PatellaPartial
  end
```

Add a controller:
```ruby
  class PatellaController < ApplicationController
    include Patella::Actions
    helper :some_app_helper_i_need
end
```

Then in your view:

```haml
= patella_partial @some_patella_obj, 'path/to/my/partial', :extra_things => :to_render_partial
```

And in the partial:

```haml

- your_patella_result = patella_obj
- lookup = User.find(extra_things)

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
