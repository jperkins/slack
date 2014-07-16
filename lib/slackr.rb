require "slackr/connection"
require "slackr/errors"
require "slackr/version"


class Slackr
  def initialize(token)
    @connection = Slackr::Connection.new(token)
  end

	# Returns a list of all channels for the team.
	#
	# Returned channels include: the channel the caller is in, channels they
	# are not currently in, and archived channels. The number of
  # (non-deactivated) members in each channel is also returned.
	#
	# == Parameters
	#
	# * +exclude_archived+ Don't return archived channels. Optional.
	# 	Default false.
	#
	# == Examples
	#
	# slackr = Slackr.new(token)
	#
	# slackr.list_channels
	# => [TODO: insert sample returned code]
  def list_channels(opts={})
    response = @connection.request('channels.list', opts)
  end

  # Returns a portion of messages/events for the specified channel.
  #
  # To read the entire history for a channel, call the method with no
  # +latest+ or +oldest+ arguments, and then continue paging using the
  # instructions below.
  #
  #	The +latest+ and +oldest+ timestamps (if specified as arguments) are
  #	returned, along with the most recent 100 messages from between (not
  #	inclusive) the two timestamps. If there were more than 100 messages
  #	between those two points, then +has_more+ will be true. In this case, a
  #	client can make another call, using the +ts+ value of the final message
  #	as the +latest+ param, to get the next "page" of messages. The
  #	+is_limited+ boolean is only included for free teams that have reached
  #	the free message limit. If true, there are messages before the current
  #	result set, but they are beyond the message limit.
  #
  # Messages of type "message" are user-entered text messages sent to the
  # channel, while other types are events that happened within the channel.
  # All messages have both a +type+ and a sortable +ts+, but the other fields
  # depend on the type. For a list of all possible events, see the channel
  # messages documentation.
  #
  # If a message has been starred by the calling user, the +is_starred+
  # property will be present and true. This property is only added for
  # starred items, so is not present in the majority of messages.
  #
  # == Arguments
  #
  # * +channel_id+ ID of channel to fetch history for. Required.
  #
  # * +latest+ Timestamp of the oldest recent seen message.
  # 	Optional, default=now.
  #
  # * +oldest+ Timestamp of the latest previously seen message.
  # 	Optional, default=0.
  #
  # * +count+ Number of messages to return, between 1 and 1000.
  # 	Optional, default=100
	#
	# == Errors
	#
	# * +channel_not_found+ Value passed for channel was invalid.
	#
	# * +invalid_ts_latest+ Value passed for latest was invalid
	#
	# * +invalid_ts_oldest+ Value passed for oldest was invalid
  def channel_history(channel_id='', opts={})
    if channel_id.to_s == ''
      raise Slackr::ArgumentError,
        "A channel id must be provided to Slackr#channel_history"
    end

    @connection.request('channels.history', channel_id)
  end
end
