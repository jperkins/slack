require 'spec_helper'

describe Slack do
  context "#new" do
    before(:each) do
      stub_auth_test_invocation
    end

    it "returns an instance of Slack" do
      slack = Slack.new('token')

      slack.should be_an_instance_of Slack
    end
  end

  # -----------------------------------
  # list_channels
  # -----------------------------------
  context "#list_channels" do
    before(:each) do
      stub_auth_test_invocation

      @slack = Slack.new('token')
    end

    it "sends a `channels.list` message to connection" do
      Slack::Connection.any_instance.
        should_receive(:request).
        with('channels.list', {})

      @slack.list_channels
    end
  end

  # -----------------------------------
  # channel_history
  # -----------------------------------
  context "#channel_history" do
    before(:each) do
      stub_auth_test_invocation
      @slack = Slack.new('token')
    end

    it "sends a channel_history message to connection" do
      Slack::Connection.any_instance.should_receive(:request).
        with('channels.history', 123)

      @slack.channel_history(123)
    end

    it "raises an exception if channel_id isn't provided" do
      expect {
        @slack.channel_history
      }.to raise_error(
        Slack::ArgumentError,
        "A channel id must be provided to Slack#channel_history")
    end
  end


private

  def stub_auth_test_invocation
    stub_request(:get, "https://slack.com/api/auth.test?token=token").
      to_return(:body => '{"ok": true}')
  end
end
