module Bot::DiscordCommands
  module Help
    extend Discordrb::Commands::CommandContainer
	  
	  command(:help) do |event|
				
			event.channel.send_embed do |embed|
				embed.colour = 0xff8040 #orange
				embed.add_field name: "**information bot :**", value: "``atem:info``"
				embed.add_field name: "**search card :**", value: "``::name_card::`` | example ``::dark magician::``"
			end
	  end
	  
  end
end