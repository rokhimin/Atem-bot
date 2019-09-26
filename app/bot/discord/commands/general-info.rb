module Bot::DiscordCommands
  module Info
    extend Discordrb::Commands::CommandContainer
	  
	  command(:info) do |event|
				event.channel.send_embed do |embed|
				embed.colour = 0xff8040 #orange
				embed.description = "**Name**     : Atem bot
									**Version**   : 1.1.4
									**Developer** : [@whdzera](https://github.com/whdzera) , [@rokhimin](https://github.com/rokhimin)
									**Written**   : Ruby Language (discordrb)
									**Link**      : https://github.com/rokhimin/Atem-yugioh-bot"
				end
	  end
	  
  end
end