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
    assert_equal '[{"1":2},{"2":4}]', render('block', :json)
  end
  
  def test_json_callback
    @controller.params[:callback] = 'myFunction'
    assert_equal 'myFunction([{"1":2},{"2":4}])', render('block', :json)
  end

  def test_xml
    assert_equal %{<?xml version="1.0" encoding="UTF-8"?>\n<tests type="array">\n  <test 1="2" type="hash"/>\n  <test 2="4" type="hash"/>\n</tests>\n}, render('block', :xml)
  end
  
  def test_instance_variable
    assert_equal '["bar"]', render('instance_variable', :json, 'foo' => 'bar')
  end
end
