require "json"
require "net/http"
require "net/https"
require "open-uri"
require "uri"


class Slackr
  class Connection
    def initialize(token)
      if token.to_s == ''
        raise Slackr::ArgumentError, "token required"
      end

      @token = token

      establish_connection
      test_authentication
    end

    def request(method='')
      if method.to_s == ''
        raise Slackr::ArgumentError,
          "No method provided in call to Connection#request"
      end

      query_string = URI::encode("token=#{@token}")
      path         = "#{@uri.request_uri}#{method}?#{query_string}"

      request = Net::HTTP::Get.new(path)

      request["User-Agent"] = "Slack Ruby Client"
      request["Accept"]     = "application/json; charset=utf-8"

      response = @connection.request(request)

      if response.body.to_s == ''
        raise Slackr::ServiceError, "Body of response was empty"
      else
        JSON.parse(response.body.to_s)
      end
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
