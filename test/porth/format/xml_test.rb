require 'test_helper'

class Format::XMLTest < MiniTest::Unit::TestCase
  def mock_controller name
    instance_eval <<-RUBY_STRING
      Class.new do
        include Format::XML::ControllerExtensions
        
        public :xml_root, :xml_pluralized_root, :xml_singularized_root
        
        def self.name
          '#{name}'
        end
      end
    RUBY_STRING
  end
  
  def test_xml_root
    assert_equal 'foo', mock_controller('Foo').new.xml_root
    assert_equal 'foo', mock_controller('FooController').new.xml_root
    assert_equal 'foos', mock_controller('FoosController').new.xml_root
    assert_equal 'bar', mock_controller('Foo::BarController').new.xml_root
  end
  
  def test_xml_pluralized_root
    assert_equal 'foos', mock_controller('Foo').new.xml_pluralized_root
    assert_equal 'foos', mock_controller('Foos').new.xml_pluralized_root
  end
  
  def test_xml_singularized_root
    assert_equal 'foo', mock_controller('Foo').new.xml_singularized_root
    assert_equal 'foo', mock_controller('Foos').new.xml_singularized_root
  end
end
