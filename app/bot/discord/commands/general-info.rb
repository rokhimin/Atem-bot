module Bot::DiscordCommands
  module Info
    extend Discordrb::Commands::CommandContainer
	  
	  command(:info) do |event|
				event.channel.send_embed do |embed|
				embed.colour = 0xff8040
				embed.add_field name: "**Information Bot**", value: "**Name**    : Atem bot 
									**Version**   : 1.3.7
									**Developer** : [@whdzera](https://github.com/whdzera) , [@rokhimin](https://github.com/rokhimin)
									**Written**   : Ruby Language (discordrb)
									**Link**      : invite bot [here](https://github.com/ft-whdzera/Atem-bot)"
				end
	  end
	  
  end
end