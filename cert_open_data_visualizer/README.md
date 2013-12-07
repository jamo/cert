# CertOpenDataVisualizer
This is Jarmo Isotalo's project for software facrory application. I don't recommend using this gem in production... :)

This is a gem for analysing cert open data, and givs twi exactly specified outputs of it.

This Gem includes a library functionality as well as command line client

## Whats new?

- Included visualization app to gem - `cert_open_data_visualizer app`
- Filter list by city name, and show details for those cities (name can match partially) `cert_open_data_visualizer city hel`


## Installation

Add this line to your application's Gemfile:

    gem 'cert_open_data_visualizer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cert_open_data_visualizer

## Usage

### Example


#### Example using command line client
```bash
$ cert_open_data_visualizer #=> prints help
#=> Commands are:
#=>   first  - prints results in format required for first print
#=>   second - prints results in format required for second print
#=>   help   - shows this
#=>   clean  - cleanes cache
#=>   fetch  - fetches new data if neccessary
#=>   app    - launces web server for visualizations in http://127.0.0.1:4567
#=>   city   - `city hel` - list details for each city containing `hel`
#=>
#=> Commands may download and parse data when neccesary.
#=> Data is cached so running commands gest faster when repeating those.
#=>

#=> A file cache is utilised for faster results.
#=> ie. information is calculated only when necessary, and cached for
#=> further use. Cache may be cleared using `clean`


$ cert_open_data_visualizer first #=> Prints output specified by exercise description
$ cert_open_data_visualizer second #=> Prints output specified by exercise description

$ cert_open_data_visualizer clean #=> Cleans cache

$ cert_open_data_visualizer city hel # Lists cities containing word given as parameter
                                     # If multiple parameters are given, results are
                                     # listed separately for each
```

#### Example using this as a library
```ruby
require 'cert_open_data_visualizer'

# this will fetch and parse data
visualizer = CertDataVisualizer.new
visualizer.first_format
visualizer.second_format

# Will crear cache. After this you need explicitely redownload everything (or create new instance)
visualiser.clear_cache!
# will redownload and reparse everything if needed
visualizer.fetch!
```

If one really wants to play around with this gem, one may try using this gem in irb `irb -Ilib -rcert_open_data_visualizer`
Ofcourse one may install this gem and require it in irb.
Or just use this from any sourse code

