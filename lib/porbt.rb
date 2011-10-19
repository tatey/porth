require 'json'

require 'porbt/unknown_format_error'
require 'porbt/format/json'
require 'porbt/format/xml'
require 'porbt/handler'

ActionView::Template.register_template_handler :rb, Porbt::Handler
