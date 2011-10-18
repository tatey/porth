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
    assert_equal '[{"1":2},{"2":4}]', render('view', :json)
  end
  
  def test_json_p
    assert_equal 'myFunction([{"1":2},{"2":4}])', render('view', :json, :callback => 'myFunction')
  end
  
  def test_xml
    assert_equal '<?xml version="1.0" encoding="UTF-8"?>\n<objects type="array">\n  <object>\n    <1 type="integer">2</1>\n  </object>\n  <object>\n    <2 type="integer">4</2>\n  </object>\n</objects>\n', render('view', :xml)
  end
end
