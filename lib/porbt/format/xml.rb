module Porbt
  module Format
    class XML
      def self.call object, options
        object.to_xml
      end
    end
  end  
end
