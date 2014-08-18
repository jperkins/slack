"But just to show how stubbornly an idea can hang on, all through the seventies
and eighties, there were many people who tried to get by with 'Remote Procedure
Call' instead of thinking about objects and messages. *Sic transit gloria
mundi*."

— Alan Kay


# Slack API Information

Sourced from the Slack API documentation.


## API Basics

The Slack web API consists of HTTP RPC-style methods, all of the form:

    https://slack.com/api/METHOD

* All methods must be called using `HTTPS`.

* Arguments can be passed as `GET` or `POST` params, or a mix.

* The response contains a `JSON` object, which will always contain a top-level
  boolean property `ok`, indicating success or failure.

* For failure results, the error property will contain a short machine-readable
  error code.

Examples:

    {
    	"ok": true,
    	"stuff": "This is good"
    }

    {
    	"ok": false,
    	"error": "something_bad"
    }

Other properties are defined in the documentation for the relevant method.


## Authentication

API authentication is achieved via a bearer token which identifies a single
user. You can either use a generated full-access token, or register your
application with us and use OAuth 2. If you plan to authenticate several users,
we strongly recommend using OAuth.


## API Methods

### Users

* `users.list` Lists all users in a Slack team.

### Channels

* `channels.info` Gets information about a channel.
* `channels.join` Joins a channel, creating it if needed.
* `channels.leave` Leaves a channel.
* `channels.history` Fetches history of messages and events from a channel.
* `channels.mark` Sets the read cursor in a channel.
* `channels.invite` Invites a user to a channel.
* `channels.list` Lists all channels in a Slack team.

### Files

* `files.upload` Uploads or creates a file.
* `files.list` Lists & filters team files.
* `files.info` Gets information about a team file.

### IM

* `im.history` Fetches history of messages and events from direct message channel.
* `im.list` Lists direct message channels for the calling user.

### Groups

* `groups.history` Fetches history of messages and events from a private group.
* `groups.list` Lists private groups that the calling user has access to.

### Search

* `search.all` Searches for messages and files matching a query.
* `search.files` Searches for files matching a query.
* `search.messages` Searches for messages matching a query.

### Chat

* `chat.update` Updates a message.
* `chat.delete` Deletes a message.
* `chat.postMessage` Sends a message to a channel.

### Stars

* `stars.list` Lists stars for a user.

### Auth

* `auth.test` Checks authentication & identity.

### Oath

* `oauth.access` Exchanges a temporary OAuth code for an API token.

### Emoji

* `emoji.list` Lists custom emoji for a team.


## Rate limits

The Slack API and all integrations are subject to rate limiting.

### Message Posting

In general we allow applications that integrate with Slack to send no more than
one message per second.

We allow bursts over that limit for short periods. However, if your integration
continues to exceed the limit over a longer period of time, Slack will start
returning a HTTP 429 Too Many Requests error, a `JSON` object containing the
number of calls you have been making, and a `Retry-After` header containing the
number of seconds until you can retry. Continuing to send requests after being
rate limited runs the risk of having your application permanently disabled.

These limits exist because Slack is primarily a communication tool for humans.
Our goal is to detect applications that may be unintentionally spammy and quiet
them down to avoid hindering a team’s ability to communicate and use their
archive.

