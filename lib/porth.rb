require 'action_controller'

require 'porth/format/json'
require 'porth/format/xml'
require 'porth/handler'
require 'porth/unknown_format_error'

Porth::Handler.register_format :json, Porth::Format::JSON
Porth::Handler.register_format :xml,  Porth::Format::XML

ActionView::Template.register_template_handler :rb, Porth::Handler
