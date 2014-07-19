# Slack

Ruby client for the Slack service.

## Installation

Add this line to your application's Gemfile:

    gem 'slack'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slack

## Usage

    slack = Slack.new(token)
    slack.test_authentication

    slack.list_channels
    slack.channel_history(channel_id)



## Contributing

1. Fork it ( https://github.com/jperkins/slack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
