require 'spec_helper'

describe Slackr::Connection do

  # -----------------------------------
  # new
  # -----------------------------------
  describe "#new" do
    context "with invalid parameters" do
      it "raises an exception when token is nil" do
        expect {
          Slackr::Connection.new(nil)
        }.to raise_error(Slackr::ArgumentError, 'token required')
      end

      it "raises an exception when token is blank" do
        expect {
          Slackr::Connection.new('')
        }.to raise_error(Slackr::ArgumentError, 'token required')
      end

      it "raises an exception when token is invalid" do
        response_body = %q|{"ok": false, "error": "invalid_auth"}|
        auth_stub_with_response_body(response_body)

        expect {
          Slackr::Connection.new('token')
        }.to raise_error(
          Slackr::AuthenticationError,
          'Invalid authentication token.'
        )
      end

      it "raises an exception when token is for deleted user or team" do
        response_body = %q|{"ok": false, "error": "account_inactive"}|
        auth_stub_with_response_body(response_body)

        expect {
          Slackr::Connection.new('token')
        }.to raise_error(
          Slackr::AuthenticationError,
          'Authentication token is for a deleted user or team.'
        )
      end
    end

    context "with valid parameters" do
      it "makes an HTTP request to test the authentication" do
        response_body = %q|{"ok": true}|
        auth_stub_with_response_body(response_body)

        Slackr::Connection.new('token')
      end
    end
  end

  # -----------------------------------
  # request
  # -----------------------------------
  describe "#request" do
    context "when the request to auth.test is made" do
      it "builds a path that includes the supplied method" do
        stub_request(:get, "https://slack.com/api/auth.test?token=token").
          to_return(:body => '{"ok": true}')

        Slackr::Connection.new('token')
      end

      it "includes the token in the query string" do
        stub_request(:get, "https://slack.com/api/auth.test").
          with(:query => { 'token' => 'token' }).
          to_return(:body => '{"ok": true}')

        Slackr::Connection.new('token')
      end

      it "raises an exception if called without a method" do
        stub_request(:get, "https://slack.com/api/auth.test?token=token").
          to_return(:body => '{"ok": true}')

        connection = Slackr::Connection.new('token')

        expect {
          connection.request
        }.to raise_error(
          Slackr::ArgumentError,
          'No method provided in call to Connection#request'
        )
      end

      it "makes an HTTP request that includes a User-Agent header" do
        stub_request(:get, "https://slack.com/api/auth.test").
          with(
            :query => {'token' => 'token'},
            :headers => {'User-Agent' => 'Slack Ruby Client'}
          ).to_return(:body => '{"ok": true}')

        connection = Slackr::Connection.new('token')
      end

      it "makes an HTTP request that includes an Accept header" do
        stub_request(:get, "https://slack.com/api/auth.test").
          with(
            :query => {'token' => 'token'},
            :headers => {'Accept' => 'application/json; charset=utf-8'}
          ).to_return(:body => '{"ok": true}')

        connection = Slackr::Connection.new('token')
      end

      it "returns the body of the response as a JSON object" do
        response_body = %q|{"ok": true}|
        auth_stub_with_response_body(response_body)

        connection = Slackr::Connection.new('token')
        response = connection.request('auth.test')

        response.should be_an_instance_of Hash
      end

      it "raises an exception if response.body is empty" do
        response_body = nil
        auth_stub_with_response_body(response_body)

        expect {
          Slackr::Connection.new('token')
        }.to raise_error(
          Slackr::ServiceError,
          'Body of response was empty'
        )
      end
    end
  end


private

  def auth_stub_with_response_body(body)
    stub_request(
      :get,
      "https://slack.com/api/auth.test"
    ).with(
      :query   => {"token" => 'token'}
    ).to_return(
      :status  => 200,
      :body    => body,
      :headers => {}
    )
  end
end
