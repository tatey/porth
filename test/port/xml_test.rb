require 'test_helper'

class XMLTest < MiniTest::Unit::TestCase
  def klass name
    instance_eval <<-RUBY_STRING
      Class.new do
        include Format::XML::ControllerExtensions
        
        def self.name
          '#{name}'
        end
      end
    RUBY_STRING
  end
  
  def test_xml_root    
    assert_equal 'foos', klass('Foo').new.xml_root
    assert_equal 'foos', klass('FooController').new.xml_root
    assert_equal 'foos', klass('FoosController').new.xml_root
    assert_equal 'bars', klass('Foo::BarController').new.xml_root
  end
end
