require 'spec_helper'

describe Slackr do
  context "#new" do
    before(:each) do
      stub_request(:get, "https://slack.com/api/auth.test?token=token").
        to_return(:body => '{"ok": true}')
    end

    it "returns an instance of Slackr" do
      slackr = Slackr.new('token')

      slackr.should be_an_instance_of Slackr
    end
  end

  # -----------------------------------
  # list_channels
  # -----------------------------------
  context "#list_channels" do
    before(:each) do
      stub_request(:get, "https://slack.com/api/auth.test?token=token").
        to_return(:body => '{"ok": true}')

      @slackr = Slackr.new('token')
    end

    it "sends a `channels.list` message to connection" do
      Slackr::Connection.any_instance.
        should_receive(:request).
        with('channels.list', {})

      @slackr.list_channels
    end
  end

  # -----------------------------------
  # channel_history
  # -----------------------------------
  context "#channel_history" do
    before(:each) do
      stub_request(:get, "https://slack.com/api/auth.test?token=token").
        to_return(:body => '{"ok": true}')

      @slackr = Slackr.new('token')
    end

    it "sends a channel_history message to connection" do
      Slackr::Connection.any_instance.should_receive(:request).
        with('channels.history', 123)

      @slackr.channel_history(123)
    end

    it "raises an exception if channel_id isn't provided" do
      expect {
        @slackr.channel_history
      }.to raise_error(
        Slackr::ArgumentError,
        "A channel id must be provided to Slackr#channel_history")
    end
  end
end
