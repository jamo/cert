# CertOpenDataVisualizer


## Installation

Add this line to your application's Gemfile:

    gem 'cert_open_data_visualizer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cert_open_data_visualizer

## Usage

### Example
```ruby
require 'cert_open_data_visualizer'

# this will fetch and parse data
visualizer = CertDataVisualizer.new
visualizer.first_format
visualizer.second_format

# Will crear cache. After this you need explicitely redownload everything (or create new instance)
visualiser.crear_cache!
# will redownload and reparse everything if needed
visualizer.fetch!

```

If one really wants to play around with this gem, one may try using this gem in irb `irb -Ilib -rcert_open_data_visualizer`
Ofcourse one may install this gem and require it in irb.
Or just use this from any sourse code

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


