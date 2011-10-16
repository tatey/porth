require 'json'

require 'porbt/format/json'
require 'porbt/format/xml'
require 'porbt/handler'

if defined? ActionView::Template
  ActionView::Template.register_template_handler :rb, Porbt::Handler
end
