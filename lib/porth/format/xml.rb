module Porth
  module Format
    class XML
      def self.call object, assigns
        object.to_xml :root => assigns['xml_root']
      end
    end
  end  
end
