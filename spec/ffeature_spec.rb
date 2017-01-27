require "spec_helper"
require "flipper/adapters/memory"

# rubocop:disable RSpec/FilePath
# rubocop:disable Metrics/BlockLength
describe FFeature do
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

  it "has dev_mode" do
    expect(described_class.dev_mode).to be_falsey
  end

  it "has flipper" do
    expect(described_class.flipper).to be
  end

  it "has feature" do
    expect(described_class.features).to eql([:archived])
  end

  context "when feature in default state (enabled for testers only)" do
    it "toggles feature for testers" do
      expect(described_class.enabled?(:archived, tester)).to be_truthy
    end

    it "toggles feature for decorated testers" do
      expect(described_class.enabled?(:archived, tester.decorate)).to be_truthy
    end

    it "does not toggle feature for other users" do
      expect(described_class.enabled?(:archived, user)).to be_falsey
    end

    it "does not toggle feature for nil" do
      expect(described_class.enabled?(:archived, nil)).to be_falsey
      expect(described_class.enabled?(:archived)).to be_falsey
    end
  end

  context "when feature disabled" do
    before do
      described_class.flipper[:archived].disable
    end

    it "does not toggle feature for testers" do
      expect(described_class.enabled?(:archived, tester)).to be_falsey
    end

    it "does not toggle feature for other users" do
      expect(described_class.enabled?(:archived, user)).to be_falsey
    end

    it "does not toggle feature for nil user" do
      expect(described_class.enabled?(:archived, nil)).to be_falsey
      expect(described_class.enabled?(:archived)).to be_falsey
    end
  end
end
