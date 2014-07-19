# Slackr

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'slackr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slackr

## Usage

    slackr = Slackr.new(token)
    slackr.test_authentication

    slackr.list_channels
    slackr.channel_history(channel_id)



## Contributing

1. Fork it ( https://github.com/jperkins/slackr/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
