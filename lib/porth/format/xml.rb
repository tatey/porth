module Porth
  module Format
    class XML
      def self.call object, assigns
        object.to_xml
      end
    end
  end  
end
