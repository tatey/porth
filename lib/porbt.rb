require 'json'

require 'porbt/format/json'
require 'porbt/format/xml'
require 'porbt/handler'
require 'porbt/unknown_format_error'

ActionView::Template.register_template_handler :rb, Porbt::Handler
