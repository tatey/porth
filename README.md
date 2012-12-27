# Deprecated

**TL;DR** This library is deprecated and will no longer be maintained. You should consider
migrating to [ActiveModel::Serializer](https://github.com/rails-api/active_model_serializers).

Porth was a joy to create and use, but it's time to recognise when other libraries 
do it better. The principle idea behind Porth was to separate the JSON and XML
representations of your models.

[ActiveModel::Serializer](https://github.com/rails-api/active_model_serializers)
is a better library with a tonne of support from the community. I would personally
choose this for my next API.

Thank you for supporting Porth.

# Porth (Plain Old Ruby Template Handler)

[![Build Status](https://secure.travis-ci.org/tatey/porth.png)](http://travis-ci.org/tatey/porth)

Write your views using plain old Ruby. Views are for representation, not defining
`#as_json` in a model. There's no need to learn a DSL for building arrays and hashes.
Just use Ruby. Views are written once and rendered in JSON(P) or XML based on
the requested format. Porth makes few assumptions and can be configured.

## Installation

Add this to your project's Gemfile and run `$ bundle install`

``` ruby
gem 'porth'
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

Resource names are pluralized or singularized by introspecting the return type from
the view. Following convention, collection actions (index) should return 
an array of objects and member actions (new, create, edit, update, delete) should 
return an object. Override `#xml_pluralized_root` to explicitly set the collection 
resource name and override `#xml_singularize_root` to explicitly set the member 
resource name.

``` ruby
class SeaFoodsController < ApplicationController
  # ...

  protected
  
  def xml_pluralized_root
    'fish'
  end
          
  def xml_singularized_root
    'fish'
  end
end
```

## Examples

Remember, anything you can do in Ruby you can do in Porth. Here are a few ideas
for writing and testing your views.

### Subset

Conveniently select a subset of attributes.

``` ruby
# app/views/users/show.rb
@author.attributes.slice 'id', 'first_name', 'last_name', 'email'
```

### Variable and Condition

Hashes may get dirty if you attempt to build them all in one go. Consider storing
the hash in a variable and adding to it based on a condition. Like a method you
need to return the hash on the last line.

``` ruby
# app/views/users/show.rb
attributes = @author.attributes.slice 'id', 'first_name', 'last_name', 'email'
if current_user.admin?
  attributes['ip_address'] = @author.ip_address
  attributes['likability'] = @author.determine_likability_as_of Time.current
end
attributes
```

### Functional Test

Use functional tests to verify the response's body is correct.

``` ruby
# app/views/posts/show.rb
@author.attributes.slice 'id', 'title', 'body'
```

JSON maps well to Ruby's hashes. Set the response to JSON, parse the body into 
a hash and verify the key-value pairs.

``` ruby
# test/functional/posts_controller_test.rb
require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  # ...
  
  test "GET show" do
    get :show, id: posts(:hello_word).id, format: 'json'
    post = JSON.parse response.body
    assert_equal 123040040, post['id']
    assert_equal 'Hello, World!', post['title']
    assert_equal 'Lorem ipsum dolar sit amet...', post['body']
  end
end
```

## Compatibility

* MRI 1.8.7
* MRI 1.9.2+
* JRuby 1.6.4+

## Dependancies

* ActionPack 3.0.0+

## Extensions

* [porth-plist](https://github.com/soundevolution/porth-plist) - Adds Property list (.plist) support

## Contributing

1. Fork
2. Install dependancies by running `$ bundle install`
3. Write tests and code
4. Make sure the tests pass by running `$ bundle exec rake`
5. Push and send a pull request on GitHub

## Credits

Porth is the result of numerous discussions at [Everyday Hero](http://www.everydayhero.com.au) 
around better API design.

## Copyright

Copyright © 2011 Tate Johnson. Released under the MIT license. See LICENSE.
