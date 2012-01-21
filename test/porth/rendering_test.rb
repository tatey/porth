require 'active_support/core_ext/hash'
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
    assert_equal "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<tests type=\"array\">\n  <test>\n    <value type=\"integer\">1</value>\n  </test>\n  <test>\n    <value type=\"integer\">2</value>\n  </test>\n</tests>\n", render(:block, :xml)
  end
  
  def test_xml_root
    collection = REXML::Document.new render('collection', :xml)
    singular   = REXML::Document.new render('singular', :xml)    
    assert_equal 'tests', collection.root.name
    assert_equal 'test', singular.root.name
  end
  
  def test_instance_variable
    assert_equal '["bar"]', render('instance_variable', :json, 'foo' => 'bar')
  end
end
