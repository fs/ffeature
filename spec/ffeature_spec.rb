require "spec_helper"
require "flipper/adapters/memory"

describe FFeature do # rubocop:disable RSpec/FilePath
  let(:tester) { SampleUser.new(1, true) }
  let(:user) { SampleUser.new(2, false) }

  before do
    described_class.reset!

    described_class.configure do |config|
      config.flipper = Flipper.new(Flipper::Adapters::Memory.new)
      config.features = %i(archived)
      config.dev_mode = false
    end
  end

  it "has config" do
    expect(described_class.dev_mode).to be_falsey
    expect(described_class.flipper).to be
    expect(described_class.features).to eql([:archived])
  end

  it "toggles feature for testers" do
    expect(described_class.enabled?(:archived, tester)).to be_truthy
  end

  it "toggles feature for decorated testers" do
    expect(described_class.enabled?(:archived, tester.decorate)).to be_truthy
  end

  it "does not toggle feature for other users" do
    expect(described_class.enabled?(:archived, user)).to be_falsey
  end
end
