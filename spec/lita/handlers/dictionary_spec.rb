require "spec_helper"

describe Lita::Handlers::Dictionary, lita_handler: true do
  describe "Lita command route" do
    it { is_expected.to route_command("j2e").to(:translate_jp2en) }
  end

  describe "j2e command" do
    it "replies to a j2e command" do
      send_command("j2e りんご")
      expect(replies.last).to include("apple")
    end
  end

  describe "#translate_jp2en" do
    #let(:dict) { Lita::Handlers::Dictionary.new }
    #example "りんご -> Apple" do
    #  expect(replies.last).to eq "Apple"
    #end
  end

  describe "#dejizoitem" do
    let(:itemid) { Lita::Handlers::Dictionary.new.dejizoitem("りんご") }
    example "return String" do
      expect(itemid).to be_a(String)
    end
  end

  describe "#dejizoresult" do
    let(:result) { Lita::Handlers::Dictionary.new.dejizoresult("020020") }
    example "return String" do
      expect(result).to be_a(String)
    end
  end
end
