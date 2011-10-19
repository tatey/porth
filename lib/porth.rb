require 'json'

require 'porth/format/json'
require 'porth/format/xml'
require 'porth/handler'
require 'porth/unknown_format_error'

ActionView::Template.register_template_handler :rb, Porth::Handler
