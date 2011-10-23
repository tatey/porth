module Porth
  module Format
    module JSON
      def self.call controller, object
        json     = object.to_json
        callback = controller.send :json_callback
        callback ? "#{callback}(#{json})" : json
      end
      
      module ControllerExtensions
        protected
        
        def json_callback
          params[:callback]
        end
      end
    end
  end
end
