module Porbt
  class Handler
    attr_reader :template
    
    def initialize template
      @template = template
    end
    
    def call
      "Porbt::Format::#{format}.call @_assigns, #{compile}"
    end

    def compile
      instance_eval template.source
    end
    
    def format
      {:json => 'JSON', :xml => 'XML'}.fetch(template.formats.first) { raise }
    end
    
    def self.call template
      new(template).call
    end
  end
end
