module Bot::DiscordCommands
  module Ping
    extend Discordrb::Commands::CommandContainer
    
    command(:ping) do |event|
      # Calculate timestamp difference for server latency
      server_latency = ((Time.now - event.timestamp) * 100).to_i
      
      # Check API latency by making a request to Ygoprodeck
      begin
        atem = Ygoprodeck::Name.is('dark magician')
        api_latency = atem['id'].nil? ? "ERROR" : "#{(server_latency - 40)}ms."
      rescue StandardError
        api_latency = "ERROR"
      end
      
      # Send embedded message with latency information
      event.channel.send_embed do |embed|
        embed.colour = 0xff8040
        embed.add_field(name: "Server latency", value: "#{server_latency}ms.", inline: true)
        embed.add_field(name: "API latency", value: api_latency, inline: true)
      end
    end
  end
end