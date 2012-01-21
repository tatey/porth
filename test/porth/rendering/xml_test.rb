require 'active_support/core_ext/hash'
require 'rexml/document'
require 'test_helper'

class Rendering::XMLTest < MiniTest::Unit::TestCase
  include Rendering
  
  def test_render_xml
    assert_equal "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<mocks type=\"array\">\n  <mock>\n    <value type=\"integer\">1</value>\n  </mock>\n  <mock>\n    <value type=\"integer\">2</value>\n  </mock>\n</mocks>\n", render(:block, :xml, MockController.new)
  end

  def test_render_xml_with_array_of_objects
    xml = REXML::Document.new render('collection', :xml, MockController.new)
    assert_equal 'mocks', xml.root.name
  end

  def test_render_xml_with_object
    xml = REXML::Document.new render('singular', :xml, MockController.new)
    assert_equal 'mock', xml.root.name
  end
end
