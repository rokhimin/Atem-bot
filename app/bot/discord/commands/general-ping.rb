module Bot::DiscordCommands
  module Ping
    extend Discordrb::Commands::CommandContainer
	  
            command(:ping) do |event|
					servers = event.bot.servers
					event.channel.send_embed do |embed|
					embed.colour = 0xff8040
					embed.add_field name: "ping", value: "#{((Time.now - event.timestamp) * 1000).to_i}ms."
                end
            end

    end
end