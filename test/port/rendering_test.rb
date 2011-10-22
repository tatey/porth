require 'action_view'
require 'test_helper'

class RenderingTest < MiniTest::Unit::TestCase
  def template_dir
    File.expand_path File.dirname(__FILE__) + '/../fixtures'
  end
  
  def render file, format, assigns = {}
    ActionView::Base.new(template_dir, assigns).tap do |view|
      view.lookup_context.freeze_formats [format]
    end.render :file => file
  end
    
  def test_json
    assert_equal '[{"1":2},{"2":4}]', render('block', :json)
  end
  
  def test_json_callback
    assert_equal 'myFunction([{"1":2},{"2":4}])', render('block', :json, 'json_callback' => 'myFunction')
  end
  
  def test_xml
    assert_equal %{<?xml version="1.0" encoding="UTF-8"?>\n<objects type="array">\n  <object 1="2" type="hash"/>\n  <object 2="4" type="hash"/>\n</objects>\n}, render('block', :xml)
  end
  
  def test_xml_root
    assert_equal %{<?xml version="1.0" encoding="UTF-8"?>\n<foos type="array">\n  <foo 1="2" type="hash"/>\n  <foo 2="4" type="hash"/>\n</foos>\n}, render('block', :xml, 'xml_root' => 'foos')    
  end
  
  def test_instance_variable
    assert_equal '["bar"]', render('instance_variable', :json, 'foo' => 'bar')
  end
end
