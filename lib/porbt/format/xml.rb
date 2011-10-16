module Porbt
  module Format
    class XML
      def self.call options, compiled
        compiled.to_xml
      end
    end
  end  
end
