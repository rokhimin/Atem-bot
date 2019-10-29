module Bot::DiscordCommands
  module Listsrccard
    extend Discordrb::Commands::CommandContainer
	  
	 	 command(:src) do |event, *from|
        temp = from.join(' ')
				atem = Ygoprodeck::List.is(temp)
				
				if atem[0]['id'] == nil				
					event.channel.send_embed do |embed|
					embed.colour = 0xff8040 #orange
					embed.add_field(name: "0 card matches for ``#{temp}``", value: "try again aibou..", inline: true)
					end
					
				else
					listing = []
					count = 35
					num_default = 0
					for logic_search in 1..35 do
						if atem[num_default] == nil
						else
						listing << atem[num_default]["name"]
						num_default += 1
						count -= 1
						end
					end
		  			
					atem_listing = listing.shuffle
					event.channel.send_embed do |embed|
					embed.colour = 0xff8040 #orange
					embed.add_field(name: "#{listing.length} card matches for ``#{temp}``", value: " #{atem_listing.join(" \n")}", inline: true)
					end
			 
				end
	  end
	  
	  
  end
end