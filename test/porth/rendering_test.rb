require 'rexml/document'
require 'test_helper'

class RenderingTest < MiniTest::Unit::TestCase
  class TestsController < ActionController::Base
    def params
      @params ||= {}
    end
  end

  def render file, format, assigns = {}
    ActionView::Base.new(template_dir, assigns, @controller).tap do |view|
      view.lookup_context.freeze_formats [format]
    end.render :file => file
  end

  def template_dir
    File.expand_path File.dirname(__FILE__) + '/../fixtures'
  end

  def setup
    @controller = TestsController.new
  end
    
  def test_json
    assert_equal '[{"value":1},{"value":2}]', render('block', :json)
  end
  
  def test_json_callback
    @controller.params[:callback] = 'myFunction'
    assert_equal 'myFunction([{"value":1},{"value":2}])', render('block', :json)
  end

  def test_xml
    xml = REXML::Document.new render('block', :xml)
    assert_equal '1', xml.root.elements[1].attributes['value']
    assert_equal 'hash', xml.root.elements[1].attributes['type']
    assert_equal '2', xml.root.elements[2].attributes['value']
    assert_equal 'hash', xml.root.elements[2].attributes['type']
  end
  
  def test_instance_variable
    assert_equal '["bar"]', render('instance_variable', :json, 'foo' => 'bar')
  end
end
