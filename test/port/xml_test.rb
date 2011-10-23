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
    assert_equal 'foos', klass('Foo').new.send(:xml_root)
    assert_equal 'foos', klass('FooController').new.send(:xml_root)
    assert_equal 'foos', klass('FoosController').new.send(:xml_root)
    assert_equal 'bars', klass('Foo::BarController').new.send(:xml_root)
  end
end
