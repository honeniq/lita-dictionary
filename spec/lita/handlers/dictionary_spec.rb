require "spec_helper"

describe Lita::Handlers::Dictionary, lita_handler: true do
  it { is_expected.to route_command("j2e").to(:j2e) }

end
