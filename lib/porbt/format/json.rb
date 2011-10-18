module Porbt
  module Format
    class JSON
      def self.call compiled, options
        compiled = compiled.to_json
        if options[:callback]
          "#{options[:callback]}(#{compiled})"
        else
          compiled
        end
      end
    end
  end
end
