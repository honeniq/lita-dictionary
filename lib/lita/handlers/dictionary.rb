module Lita
  module Handlers
    class Dictionary < Handler
      route %r{j2e}, :j2e, command: true, help: {
        "j2e" => "Translate a japanese word to english"}
      
      def j2e()
      end
    end

    Lita.register_handler(Dictionary)
  end
end
