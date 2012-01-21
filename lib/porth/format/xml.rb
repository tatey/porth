module Porth
  module Format
    module XML
      def self.call controller, object
        method = if object.respond_to?(:count) && !object.respond_to?(:keys)
          :pluralize
        else
          :singularize
        end
        object.to_xml :root => controller.send(:xml_root).send(method)
      end
      
      module ControllerExtensions
        protected
                
        def xml_root
          self.class.name.sub('Controller', '').underscore.split('/').last
        end
      end
    end
  end
end
