require "lita"
require "open-uri"
require "pry"
require "nokogiri"

Lita.load_locales Dir[File.expand_path(
  File.join("..", "..", "locales", "*.yml"), __FILE__
)]

require "lita/handlers/dictionary"

Lita::Handlers::Dictionary.template_root File.expand_path(
  File.join("..", "..", "templates"),
 __FILE__
)
