require "slackr/version"

module Slackr
  def connect(token)
    @connection = Slackr::Connection.new(token)

    return self
  end
end
