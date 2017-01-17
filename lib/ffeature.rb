require "bundler/setup"
Bundler.setup

require "flipper"
require "active_support/core_ext/module/attribute_accessors"

require "ffeature/version"
require "ffeature/feature"
require "ffeature/railtie" if defined?(Rails)

module FFeature
  cattr_accessor :ip_whitelist
  self.ip_whitelist = []

  cattr_accessor :dev_mode
  self.dev_mode = false

  cattr_accessor :features
  self.features = %i(user_management)

  cattr_accessor :flipper
  self.flipper = nil

  def self.configure
    yield(self)

    Flipper.register(:testers, &:tester?)

    features.each do |feature|
      flipper[feature].enable(flipper.group(:testers))
    end
  end

  def self.reset!
    Flipper.unregister_groups
  end

  def self.ip_allowed?(ip)
    ip_whitelist.include?(ip)
  end

  def self.enabled?(feature, user)
    Feature.new(feature).enabled?(user)
  end
end
