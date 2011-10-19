require 'json'

require 'porbt/unknown_format_error'
require 'porbt/format/json'
require 'porbt/format/xml'
require 'porbt/handler'

if defined? ActionView::Template
  ActionView::Template.register_template_handler :rb, Porbt::Handler
end
