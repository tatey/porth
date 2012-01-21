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
  
  def test_send_xml_root
    assert_equal 'foo', klass('Foo').new.send(:xml_root)
    assert_equal 'foo', klass('FooController').new.send(:xml_root)
    assert_equal 'foos', klass('FoosController').new.send(:xml_root)
    assert_equal 'bar', klass('Foo::BarController').new.send(:xml_root)
  end
end
