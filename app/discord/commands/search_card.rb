module Bot::DiscordCommands
  module SearchCard
	  
            message(description: 'searchcard') do |event, *ygo|
                card = ygo.join('')
                #url = "https://db.ygoprodeck.com/api/v5/cardinfo.php?fname=#{card}"
                #uri = URI(url)
                #response = Net::HTTP.get(uri)
                #api_ygo = JSON.parse(response)

                event.channel.send_embed do |embed|
                embed.colour = 0xff8040
                embed.add_field name: "test", value: "#{card}"
                end
            end

    end
end
