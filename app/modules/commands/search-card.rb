module Bot::DiscordCommands
  module SearchCard
    extend Discordrb::Commands::CommandContainer

            command(:card, description: 'searchcard', min_args: 1,
                   usage: 'card <query>') do |event, *ygo|
                card = ygo.join('')
                url = "https://db.ygoprodeck.com/api/v5/cardinfo.php?fname=#{card}"
                uri = URI(url)
                response = Net::HTTP.get(uri)
                api_ygo = JSON.parse(response)

                event.channel.send_embed do |embed|
                embed.colour = 0xff8040
                embed.add_field name: "test", value: "#{api_ygo["name"]}"
                end
            end

    end
end
