# FFeature

[![Build Status](https://travis-ci.org/fs/ffeature.svg?branch=master)](https://travis-ci.org/fs/ffeature)

This is simple wrapper around Flipper for Rails projects to remove ugly global variables like `$flipper`.

## Usage

* `ffeature?(feature, user = current_user)` helper in views and controllers
* `FFeature.enabled?(feature, user)` helper for PORO

Here `user` or `current_user` should respond to `tester?` method to determine feature status for specific user.

## Configuration

You can configure `FFeature` in `config/inititalizers/ffeature.rb`

```ruby
# config/inititalizers/ffeature.rb

require "flipper"
require "flipper/adapters/redis"

url = ENV.fetch("REDISTOGO_URL", ENV.fetch("REDIS_URL", nil))
url = URI.parse(url) if url.present?

redis = Redis.new(url: url)
adapter = Flipper::Adapters::Redis.new(redis)

FFeature.configure do |config|
  config.features = %i(user_management)
  config.ip_whitelist = ENV.fetch("FLIPPER_UI_IP_WHITELIST", "").split(",")
  config.flipper = Flipper.new(adapter)
  config.dev_mode = ENV["FEATURE_DEV_MODE"].present?
end
```

Following options are available:
* `features` – list of features registered for testers
* `ip_whitelist` – list of IP addresses, could be used to configure FlipperUI route constraints
* `dev_mode` – if enabled all features considered enabled for all users

## FlipperUI

You can use FlipperUI to have more robust control over features.

```ruby
# config/routes.rb
constraints(->(request) { FFeature.ip_allowed?(request.remote_ip) }) do
  mount Flipper::UI.app(FFeature.flipper) => "/flipper"
end
```
## Credits

FFeature is maintained and was written by [Flatstack](http://www.flatstack.com) with the help of our
[contributors](http://github.com/fs/rails-base/contributors).

[<img src="http://www.flatstack.com/logo.svg" width="100"/>](http://www.flatstack.com)
