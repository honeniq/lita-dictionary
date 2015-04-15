require "spec_helper"

describe Lita::Handlers::Dictionary, lita_handler: true do
  it { is_expected.to route_command("j2e").to(:j2e) }

  describe "#j2e" do
    it "replies to a j2e command" do
      send_command("j2e りんご")
      expect(replies.last).to eq("Apple")
    end
  end
end
