module Bot::DiscordCommands
  module Ping
    extend Discordrb::Commands::CommandContainer
            CONFIG = OpenStruct.new YAML.load_file 'config/config.yaml'
            command(:ping) do |event|
					url = "#{CONFIG.api}dark magician"
					uri = URI(url)
					response = Net::HTTP.get(uri)
					atem = JSON.parse(response)
					
					if atem[0] == nil
						data_api = "ERROR"
					else
						data_api = "#{((Time.now - event.timestamp) * 100 - 40).to_i}ms."
					end
				
					event.channel.send_embed do |embed|
					embed.colour = 0xff8040
					embed.add_field name: "Server latency", value: "#{((Time.now - event.timestamp) * 100).to_i}ms.", inline: true
					embed.add_field name: "API latency", value: "#{data_api}", inline: true
                	end
            end

    end
end