require 'action_view'
require 'test_helper'

class HandlerTest < MiniTest::Unit::TestCase
  def template_dir
    File.expand_path File.dirname(__FILE__) + '/../fixtures'
  end
  
  def render file, format, assigns = {}
    ActionView::Base.new(template_dir, assigns).tap do |view|
      view.lookup_context.freeze_formats [format]
    end.render :file => file
  end
    
  def test_json
    assert_equal '{"foo":"bar"}', render('show', :json)
  end
  
  def test_json_p
    assert_equal 'fn({"foo":"bar"})', render('show', :json, :callback => 'fn')
  end
  
  def test_xml
    skip
  end
end
