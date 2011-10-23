# Porth (Plain Old Ruby Template Handler)

Write your Rails views using plain old Ruby templates. You should use Porth if you feel:

* Representing data is best done in the view, not defining `#as_json` in some model
* A DSL for creating arrays and hashes is unnecessary when you could just use Ruby
* Views are defined once and rendered in JSON(P) or XML based on the requested format

## Installation

``` ruby
# Gemfile
gem 'porth'
```

``` sh
$ bundle install
```

## Usage

Create a controller that responds to JSON, XML or both.

``` ruby
# app/controllers/transmitters_controller.rb
class TransmittersController < ApplicationController
  respond_to :json, :xml
  
  def index
    @transmitters = Transmitter.all
    respond_with @transmitters
  end

  # ...
end
````

Create a template with a `.rb` extension. Write plain old Ruby. Objects
must respond to `#to_json` or `#to_xml`. Arrays and hashes are best.

``` ruby
# app/views/transmitters/index.rb
@transmitters.map do |t|
  {
    name: t.area_served,
    latitude: t.latitude,
    longitude: t.longitude,
    nearby: t.nearby.size
  }
end
```

GET /transmitters.json

``` javascript
[{"name":"Brisbane","latitude":-27.4661111111111,"longitude":152.946388888889,"nearby":11}]
```

GET /transmitters.json?callback=myFunction

``` javascript
myFunction([{"name":"Brisbane","latitude":-27.4661111111111,"longitude":152.946388888889,"nearby":11}])
```

GET /transmitters.xml

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<transmitters type="array">
  <transmitter>
    <name>Brisbane</name>
    <latitude type="float">-27.4661111111111</latitude>
    <longitude type="float">152.946388888889</longitude>
    <nearby type="integer">11</nearby>
  </transmitter>
</transmitters>
```

`Porth::UnknownFormatError` is raised when the requested format is not supported.

### JSONP

Porth calls `#json_callback` to get the function name for JSONP responses. By default
this method is added to `ActionController::Base` and returns `params[:callback]`. Override
`#json_callback` to get different behaviour.

``` ruby
class ApplicationController < ActionController::Base
  # ...

  protected
  
  def json_callback
    nil # Ignore JSONP requests
  end
end
```

### XML

Porth guesses the resource's name from the controller's class. `Foo::BarsController`
becomes `bars`. Override `#xml_root` to explicitly set the resource name.

``` ruby
class TransmittersController < ApplicationController
  # ...

  protected
  
  def xml_root
    'sites'
  end
end
```

## Compatibility

* Ruby 1.9.2
* ActionPack 3.1.0

## Contributing

1. Fork
2. Install dependancies by running `$ bundle install`
3. Write tests and code
4. Make sure the tests pass by running `$ rake`
5. Push and send a pull request on GitHub

## Copyright

Copyright © 2011 Tate Johnson. Released under the MIT license. See LICENSE.
