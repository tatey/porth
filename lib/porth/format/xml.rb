module Porth
  module Format
    module XML
      def self.call controller, object
        method = if object.respond_to?(:count) && !object.respond_to?(:keys)
          :xml_pluralized_root
        else
          :xml_singularize_root
        end
        object.to_xml :root => controller.send(method)
      end
      
      module ControllerExtensions
        protected
        
        def xml_root
          self.class.name.sub('Controller', '').underscore.split('/').last
        end
        
        def xml_pluralized_root
          xml_root.pluralize
        end
                
        def xml_singularize_root
          xml_root.singularize
        end
      end
    end
  end
end
