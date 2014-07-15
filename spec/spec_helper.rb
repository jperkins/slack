$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'slackr'
require 'webmock/rspec'

RSpec.configure do |config|
  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true
end

# WebMock.allow_net_connect!(:net_http_connect_on_start => true)
# WebMock.disable_net_connect!(allow_localhost: true)
