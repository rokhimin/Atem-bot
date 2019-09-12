module Bot::DiscordCommands
  module Info
    extend Discordrb::Commands::CommandContainer
	  
	  command(:info) do |event|
				event.channel.send_embed do |embed|
				embed.colour = 0xff8040 #orange
				embed.description = "**Name**     : Atem bot
									**Version**   : 1.1.0
									**Developer** : @whdzera#3629 , @rokhiminwahid#7124 
									**Written**   : Ruby Language (discordrb)"
				end
	  end
	  
  end
end