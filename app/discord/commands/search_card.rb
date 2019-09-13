module Bot::DiscordCommands
  module SearchCard   
	  extend Discordrb::EventContainer
            CONFIG = OpenStruct.new YAML.load_file 'config/config.yaml'
	  
            message(description: 'searchcard') do |event|
                card = event.message.content
				from = /(?<=::).+(?=::)/.match(card)
				#carry = /::/.match(from)
				url = "#{CONFIG.api}#{from}"
				uri = URI(url)
				response = Net::HTTP.get(uri)
				atem = JSON.parse(response)
				
				
				if atem[0] == nil
					event.channel.send_embed do |embed|
					embed.colour = 0xff1432 #red
					embed.description = "'#{from}' not found"
                    embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://i.imgur.com/lPSo3Tt.jpg")
					end
				
				
				
				else
					unless atem[0] == nil
						
					maintype = atem[0]["type"]
					case maintype
						when "Normal Monster"
						event.channel.send_embed do |embed|
						embed.colour = 0xF8E71C #yellow
						embed.add_field name: "name", value: "#{atem[0]["name"]}"
						embed.add_field name: "type", value: "#{atem[0]["type"]}"
						end
						
						when "Spell Card"
						event.channel.send_embed do |embed|
						embed.colour = 0x7ed321 #green
						embed.add_field name: "name", value: "#{atem[0]["name"]}"
						embed.add_field name: "type", value: "#{atem[0]["type"]}"
						end
						
						when "Trap Card"
						event.channel.send_embed do |embed|
						embed.colour = 0xc51a57 #pink
						embed.add_field name: "name", value: "#{atem[0]["name"]}"
						embed.add_field name: "type", value: "#{atem[0]["type"]}"
						end
					end
					end
						
				end

            end
	  

    end
end
