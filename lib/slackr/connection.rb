require "json"
require "net/http"
require "net/https"
require "open-uri"
require "uri"


module Slackr
  class Connection
    def initialize(token)
      if token.to_s == ''
        raise Slackr::ArgumentError, "token required"
      end

      @token = token

      establish_connection
      test_authentication
    end

    def request(method)
      query_string = URI::encode("token=#{@token}")
      path         = "#{@uri.request_uri}#{method}?#{query_string}"

      request = Net::HTTP::Get.new(path)

      request["User-Agent"] = "Slack Ruby Client"
      request["Accept"]     = "application/json; charset=utf-8"

      response = @connection.request(request)

      JSON.parse(response.body)
    end


  private

    def establish_connection
      @uri = URI.parse("https://slack.com/api/")

      @connection             = Net::HTTP.new(@uri.host, @uri.port)
      @connection.use_ssl     = true
      @connection.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end

    def test_authentication
      response = self.request('auth.test')

      unless response['ok']
        if response['error'] == 'invalid_auth'
          raise Slackr::AuthenticationError,
            "Invalid authentication token."
        elsif response['error'] == 'account_inactive'
          raise Slackr::AuthenticationError,
            "Authentication token is for a deleted user or team."
        end
      end
    end
  end
end