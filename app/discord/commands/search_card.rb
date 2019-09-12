module Bot::DiscordCommands
  module SearchCard   
	  extend Discordrb::EventContainer
            CONFIG = OpenStruct.new YAML.load_file 'config/config.yaml'
	  
            message(description: 'searchcard') do |event|
                card = event.message.content
				from = /(?<=::).+(?=::)/.match(card)
				
				url = "#{CONFIG.api}#{from}"
				uri = URI(url)
				response = Net::HTTP.get(uri)
				atem = JSON.parse(response)
				
				if atem[0] == nil
					event.channel.send_embed do |embed|
					embed.colour = 0xff1432 #red
					embed.description = "'#{from}' not found"
					end
				else
					event.channel.send_embed do |embed|
					embed.colour = 0xff8040 #orange
					embed.add_field name: "name", value: "#{atem[0]["name"]}"
					embed.add_field name: "type", value: "#{atem[0]["type"]}"
				end
			end

            end
	  

    end
end
