module Porbt  
  class Handler
    attr_reader :template
    
    def initialize template
      @template = template
    end
    
    def call
      "Porbt::Format::#{format}.call instance_eval { #{template.source} }, @_assigns"
    end
    
    def format
      self.class.formats.fetch(template.formats.first) { raise UnknownFormatError }
    end
    
    def self.call template
      new(template).call
    end
    
    def self.formats
      {:json => 'JSON', :xml => 'XML'}
    end
  end
end
