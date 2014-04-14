# Dradis Client Ruby Gem [![Build Status](https://secure.travis-ci.org/dradis/dradis-client.png?branch=master)][travis] [![Dependency Status](https://gemnasium.com/dradis/dradis-client.png?travis)][gemnasium]

This gem provides a Ruby wrapper to the Dradis API (http://dradisframework.org).

[travis]: http://travis-ci.org/dradis/dradis-client
[gemnasium]: https://gemnasium.com/dradis/dradis-client

## Installation

Add this line to your application's Gemfile:

    gem 'dradis-client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dradis-client


## Configuration

To provide your access credentials:

```ruby
require 'dradis-client'

client = Dradis::Client::Endpoint.new
client.host = 'https://dradisfw.ip'
client.user = 'adama'
client.password = 'shared_password'
```

Or provide configuration in line:

```ruby
client = Dradis::Client.new(host: 'https://dradisfw.ip', user: 'adama', password: 'shared_password')
```

Or in a block

```ruby
client = Dradis::Client::Endpoint.new do |config|
  config.host          = "https://dradisfw.ip"
  config.user          = "adama"
  config.shared_secret = "shared_password"
end
```

## Usage examples

Return all the nodes in the project:

    client.nodes

Return all the notes for a given node:

    client.notes()

Get a Node by id:

```ruby
node = client.node(1)

puts node.label
puts node.notes
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Copyright

Copyright (c) 2012 Daniel Martin, Security Roots Ltd.
See [LICENSE][license] for details.

[license]: https://github.com/securityroots/vulndbhq/blob/master/LICENSE

## Acknowledgements

This gem uses the [Faraday][faraday] gem for the HTTP layer and is inspired by the [Twitter][twitter] gem architecture.

[faraday]: http://rubygems.org/gems/faraday
[twitter]: http://rubygems.org/gems/twitter
