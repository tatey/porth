require 'test_helper'

class Rendering::JSONTest < MiniTest::Unit::TestCase
  include Rendering
  
  def test_render_json
    assert_equal '[{"value":1},{"value":2}]', render('block', :json, MockController.new)
  end
  
  def test_render_json_with_callback
    controller = MockController.new
    controller.params[:callback] = 'myFunction'
    assert_equal 'myFunction([{"value":1},{"value":2}])', render('block', :json, controller)
  end
  
  def test_render_json_with_instance_variable
    assert_equal '["bar"]', render('instance_variable', :json, MockController.new, {'foo' => 'bar'})
  end
end
