module Porth
  module Format
    class JSON
      def self.call object, assigns
        json = object.to_json
        if assigns['json_callback']
          "#{assigns['json_callback']}(#{json})"
        else
          json
        end
      end
    end
  end
end
