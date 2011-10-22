module Porth  
  class Handler
    attr_reader :template
    
    def initialize template
      @template = template
    end
    
    def call
      "#{format}.call controller, instance_eval { #{template.source} }"
    end
    
    def format
      self.class.formats.fetch(template.formats.first) { raise UnknownFormatError }
    end
    
    def self.call template
      new(template).call
    end
    
    def self.formats
      @formats ||= {}
    end
    
    def self.register_format format, mod
      formats[format] = mod
      ActionController::Base.send :include, mod::ControllerExtensions
    end
  end
end
