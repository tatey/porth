module Porth
  module Format
    class JSON
      def self.call object, options
        json = object.to_json
        if options[:callback]
          "#{options[:callback]}(#{json})"
        else
          json
        end
      end
    end
  end
end
