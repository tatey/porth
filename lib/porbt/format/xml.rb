module Porbt
  module Format
    class XML
      def self.call compiled, options
        compiled.to_xml
      end
    end
  end  
end
