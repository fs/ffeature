require "bundler/setup"
Bundler.setup

require "ffeature"

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

class SampleUser
  attr_reader :id

  def initialize(id, tester)
    @id = id
    @tester = tester
  end

  def tester?
    @tester
  end

  def flipper_id
    "User:#{id}"
  end

  def to_model
    self
  end

  def decorate
    self
  end
end
