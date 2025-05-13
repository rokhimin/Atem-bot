module Bot::DiscordCommands
  module Help
    extend Discordrb::Commands::CommandContainer
	  
	  command(:help) do |event|
			event.channel.send_embed do |embed|
				embed.colour = 0xff8040
				embed.add_field name: "**information bot :**", value: "``atem:info``"
				embed.add_field name: "**ping :**", value: "``atem:ping``"
				embed.add_field name: "**search card :**", value: "``::card_name::`` | example ``::dark magician::``"
				embed.add_field name: "**search card (list) :**", value: "``atem:src card_name`` | example ``atem:src magician``"
				embed.add_field name: "**random card :**", value: "``atem:random``"
				embed.add_field name: "**tier meta deck (duel links) :**", value: "``atem:dlmeta``"
			end
	  end
  end
end