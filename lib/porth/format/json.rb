module Porth
  module Format
    module JSON
      def self.call controller, object
        json = object.to_json
        if controller.json_callback
          "#{controller.json_callback}(#{json})"
        else
          json
        end
      end
      
      module ControllerExtensions
        def json_callback
          params[:callback]
        end
      end
    end
  end
end
