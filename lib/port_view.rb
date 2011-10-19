require 'json'

require 'port_view/format/json'
require 'port_view/format/xml'
require 'port_view/handler'
require 'port_view/unknown_format_error'

ActionView::Template.register_template_handler :rb, PortView::Handler
