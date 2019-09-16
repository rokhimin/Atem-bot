module Bot::DiscordCommands
  module Listsrccard
    extend Discordrb::Commands::CommandContainer
            CONFIG = OpenStruct.new YAML.load_file 'config/config.yaml'
	  
	 	 command(:src) do |event, *from|
                temp = from.join('')
				url = "#{CONFIG.api}#{temp}"
				uri = URI(url)
				response = Net::HTTP.get(uri)
				atem = JSON.parse(response)
				
				if atem[0] == nil				
					event.channel.send_embed do |embed|
					embed.colour = 0xff8040 #orange
					  embed.add_field(name: "0 card matches for ``#{temp}``", value: "try again aibou..", inline: true)
					end
					
				else
					listing = []
					count = 30
					num_default = 0
					for logic_search in 1..30 do
						if atem[num_default] == nil
						else
						listing << atem[num_default]["name"]
						num_default += 1
						count -= 1
						end
					end
		  	
					event.channel.send_embed do |embed|
					embed.colour = 0xff8040 #orange
					  embed.add_field(name: "#{listing.length} card matches for ``#{temp}``", value: " #{listing.join(" \n")}", inline: true)
					end
			 
				end
	  end
	  
  end
end