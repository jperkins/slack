require "json"
require "net/http"
require "net/https"
# require "open-uri"
require "uri"


class Slack
  class Connection
    def initialize(token)
      if token.to_s == ''
        raise Slack::ArgumentError, "token required"
      end

      @token = token

      establish_connection
      test_authentication
    end

    def request(method_name='', opts={})
      if method_name.to_s == ''
        raise Slack::ArgumentError,
          "No method name provided"
      end

      request = build_request(method_name, opts)

      parse_response(@connection.request(request))
    end


  private

    def build_query_string(opts={})
      opts.merge!(:token => @token)
      options = []

      opts.map do |key, value|
        options << "#{URI::encode(key.to_s)}=#{URI::encode(value.to_s)}"
      end

      options.join('&')
    end

    def build_request(method_name, opts)
      query_string = build_query_string(opts)
      path         = "#{@uri.request_uri}#{method_name}?#{query_string}"

      request = Net::HTTP::Get.new(path)

      request["User-Agent"] = "Slack Ruby Client"
      request["Accept"]     = "application/json; charset=utf-8"

      request
    end

    def establish_connection
      @uri = URI.parse("https://slack.com/api/")

      @connection             = Net::HTTP.new(@uri.host, @uri.port)
      @connection.use_ssl     = true
      @connection.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end

    def parse_response(response)
      if response.body.to_s == ''
        raise Slack::ServiceError, "Body of response was empty"
      else
        json = JSON.parse(response.body.to_s)
      end

      unless json['ok']
        if json['error'] == 'invalid_auth'
          raise Slack::AuthenticationError,
            "Invalid authentication token."
        elsif json['error'] == 'account_inactive'
          raise Slack::AuthenticationError,
            "Authentication token is for a deleted user or team."
        end
      end

      json
    end

    def test_authentication
      response = self.request('auth.test')
    end
  end
end
