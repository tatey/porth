require 'action_view'
require 'test_helper'

class HandlerTest < MiniTest::Unit::TestCase
  def test_unsupported_format
    assert_raises UnknownFormatError do
      Handler.new(ActionView::Template.new(nil, nil, nil, {:format => 'text/html'})).format
    end
  end
end
