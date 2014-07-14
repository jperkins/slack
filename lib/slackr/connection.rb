# require "json"
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
    end


  private

    def create_connection
      uri = URI.parse("https://slack.com/api/")

      @connection             = Net::HTTP.new(uri.host, uri.port)
      @connection.use_ssl     = true
      @connection.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end
  end
end
