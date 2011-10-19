module Porbt
  class UnknownFormatError < StandardError
    def message
      'Unknown format. Supported formats are ' + Handler.formats.keys.join(', ')
    end
  end
end
