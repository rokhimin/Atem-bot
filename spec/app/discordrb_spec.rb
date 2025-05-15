require 'discordrb'
require_relative '../../app/bot/discord/commands/general-ping'

RSpec.describe Bot::DiscordCommands::Ping do
  let(:event) { instance_double(Discordrb::Events::MessageEvent, timestamp: Time.now) }
  let(:channel) { instance_double(Discordrb::Channel) }

  before do
    allow(event).to receive(:channel).and_return(channel)
    allow(channel).to receive(:send_embed)
  end

  it 'responds with latency embed' do
    described_class.commands[:ping].call(event)

    expect(channel).to have_received(:send_embed) do |&block|
      embed = double("Embed")
      allow(embed).to receive(:colour=)
      allow(embed).to receive(:add_field)
      block.call(embed)

      expect(embed).to have_received(:add_field).with(name: "Server latency", value: kind_of(String), inline: true)
      expect(embed).to have_received(:add_field).with(name: "API latency", value: kind_of(String), inline: true)
    end
  end
end
