module Bot::DiscordCommands
  module Ping
    extend Discordrb::Commands::CommandContainer

    command(:ping) do |event|
      server_latency = ((Time.now - event.timestamp) * 100).to_i

      begin
        atem = Ygoprodeck::Name.is('dark magician')
        api_latency = atem['id'].nil? ? 'ERROR' : "#{(server_latency - 40)}ms."
      rescue StandardError
        api_latency = 'ERROR'
      end

      event.channel.send_embed do |embed|
        embed.colour = 0xff8040
        embed.add_field(
          name: 'Server latency',
          value: "#{server_latency}ms.",
          inline: true
        )
        embed.add_field(name: 'API latency', value: api_latency, inline: true)
      end
    end
  end
end
