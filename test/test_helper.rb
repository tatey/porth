require 'minitest/autorun'
require 'porth'

module Rendering
  class MockController < ActionController::Base
    def params
      @params ||= {}
    end    
  end

  def render file, format, controller, assigns = {}
    ActionView::Base.new(template_dir, assigns, controller).tap do |view|
      view.lookup_context.freeze_formats [format]
    end.render :file => file
  end

  def template_dir
    File.expand_path File.dirname(__FILE__) + '/fixtures'
  end
end

include Porth
