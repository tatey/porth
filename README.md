# Porth (Plain Old Ruby Template Handler)

Write your Rails views using plain old Ruby templates. You should use Porth if you feel:

* Representing data is best done in the view, not defining `#as_json` in some model
* A DSL for creating arrays and hashes is unnecessary when you could just use Ruby
* Views are defined once and rendered in JSON(P) or XML based on the requested format

## Usage

Given a data structure...

``` ruby
@transmitters = [
  Transmitter.new(
    area_served: 'Brisbane', 
    latitude: -27.4661111111111, 
    longitude: 152.946388888889
  ),
  Transmitter.new(
    area_served: 'Gold Coast', 
    latitude: -27.9711111111111, 
    longitude: 153.212222222222
  )
]
```

...and a plain old ruby template

``` ruby
@transmitters.map do |t|
  {
    area_served: t.area_served,
    latitude: p.latitude,
    longitude: p.longitude,
    distance: t.distance(@location)
  }
end
```

You can have JSON...

``` javascript
[{"area_served":"Brisbane","latitude":-27.4661111111111,"longitude":152.946388888889,"distance":16700},{"area_served":"Gold Coast","latitude":-27.9711111111111,"longitude":153.212222222222,"distance":47190}]
```

...or XML

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<transmitters type="array">
  <transmitter>
    <area_served>Brisbane</area_served>
    <latitude type="float">-27.4661111111111</latitude>
    <longitude type="float">152.946388888889</longitude>
    <distance type="float">16712</distance>
  </transmitter>
  <transmitter>
    <area_served>Gold Coast</area_served>
    <latitude type="float">-27.9711111111111</latitude>
    <longitude type="float">153.212222222222</longitude>
    <distance type="float">47190</distance>
  </transmitter>
</transmitters>
```

Template files should have a `.rb` extension and follow normal conventions. Objects should 
respond to `#to_json` and `#to_xml`. Arrays and hashes are best. You'll get a `Port::UnknownFormatError`
if you use anything other than the supported formats.

## JSONP

In your controller set the callback.

``` ruby
respond_with @transmitter, :callback => params[:callback]
```

And when you hit `/transmitters/1.json?callback=myCallback` you should get back JSON wrapped in a named function.

``` javascript
myCallback({"area_served":"Brisbane","latitude":-27.4661111111111,"longitude":152.946388888889,"distance":16700})
```

## Setup

Add this to your project's Gemfile.

``` ruby
gem 'porth'
```

## Compatibility

* Ruby 1.9.2
* ActionPack 3.1.0

## Contributing

Patches welcome! 

1. Fork the repository
2. Create a topic branch
3. Write tests and make changes
4. Make sure the tests pass by running `rake`
5. Push and send a pull request on GitHub

## Copyright

Copyright © 2011 Tate Johnson. Released under the MIT license. See LICENSE.
