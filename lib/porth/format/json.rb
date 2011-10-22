module Porth
  module Format
    class JSON
      def self.call object, assigns
        json = object.to_json
        if assigns['callback']
          "#{assigns['callback']}(#{json})"
        else
          json
        end
      end
    end
  end
end
