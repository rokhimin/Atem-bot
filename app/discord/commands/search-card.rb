module Bot::DiscordCommands
  module SearchCard   
	  extend Discordrb::EventContainer
            CONFIG = OpenStruct.new YAML.load_file 'config/config.yaml'
	  
            message(description: 'searchcard') do |event|
                card = event.message.content
				from = /(?<=::).+(?=::)/.match(card)
				carry = "#{/::/.match(card)}"
				checker = '::'
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
				elsif carry == checker
					unless atem[0] == nil
					maintype = atem[0]["type"]
						case maintype
							when "Normal Monster"
								event.channel.send_embed do |embed|
								embed.colour = 0xdac14c #yellow
								embed.add_field name: "**#{atem[0]["name"]}**", value: "**Type :** #{atem[0]["type"]} \n **Attribute :** #{atem[0]["attribute"]} \n **Level :** #{atem[0]["level"]}"
								embed.add_field name: "[ #{atem[0]["race"]} ]", value: "#{atem[0]["desc"]}"
								embed.add_field name: "ATK", value: "#{atem[0]["atk"]}", inline: true
								embed.add_field name: "DEF", value: "#{atem[0]["def"]}", inline: true
                    			embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{CONFIG.api_pict}#{atem[0]["id"]}.jpg")
								end
							
							when "Effect Monster"
								event.channel.send_embed do |embed|
								embed.colour = 0xa87524 #yellowdark
								embed.add_field name: "**#{atem[0]["name"]}**", value: "**Type :** #{atem[0]["type"]} \n **Attribute :** #{atem[0]["attribute"]} \n **Level :** #{atem[0]["level"]}"
								embed.add_field name: "[ #{atem[0]["race"]} / Effect ]", value: "#{atem[0]["desc"]}"
								embed.add_field name: "ATK", value: "#{atem[0]["atk"]}", inline: true
								embed.add_field name: "DEF", value: "#{atem[0]["def"]}", inline: true
                    			embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{CONFIG.api_pict}#{atem[0]["id"]}.jpg")
								end
							
							when "Tuner Monster"
								event.channel.send_embed do |embed|
								embed.colour = 0xa87524 #yellowdark
								embed.add_field name: "**#{atem[0]["name"]}**", value: "**Type :** #{atem[0]["type"]} \n **Attribute :** #{atem[0]["attribute"]} \n **Level :** #{atem[0]["level"]}"
								embed.add_field name: "[ #{atem[0]["race"]} / Tuner / Effect ]", value: "#{atem[0]["desc"]}"
								embed.add_field name: "ATK", value: "#{atem[0]["atk"]}", inline: true
								embed.add_field name: "DEF", value: "#{atem[0]["def"]}", inline: true
                    			embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{CONFIG.api_pict}#{atem[0]["id"]}.jpg")
								end
							
							when "Spirit Monster"
								event.channel.send_embed do |embed|
								embed.colour = 0xa87524 #yellowdark
								embed.add_field name: "**#{atem[0]["name"]}**", value: "**Type :** #{atem[0]["type"]} \n **Attribute :** #{atem[0]["attribute"]} \n **Level :** #{atem[0]["level"]}"
								embed.add_field name: "[ #{atem[0]["race"]} / Spirit / Effect ]", value: "#{atem[0]["desc"]}"
								embed.add_field name: "ATK", value: "#{atem[0]["atk"]}", inline: true
								embed.add_field name: "DEF", value: "#{atem[0]["def"]}", inline: true
                    			embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{CONFIG.api_pict}#{atem[0]["id"]}.jpg")
								end
							
							when "Ritual Effect Monster"
								event.channel.send_embed do |embed|
								embed.colour = 0x293cbd #blue
								embed.add_field name: "**#{atem[0]["name"]}**", value: "**Type :** #{atem[0]["type"]} \n **Attribute :** #{atem[0]["attribute"]} \n **Level :** #{atem[0]["level"]}"
								embed.add_field name: "[ #{atem[0]["race"]} / Ritual / Effect ]", value: "#{atem[0]["desc"]}"
								embed.add_field name: "ATK", value: "#{atem[0]["atk"]}", inline: true
								embed.add_field name: "DEF", value: "#{atem[0]["def"]}", inline: true
                    			embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{CONFIG.api_pict}#{atem[0]["id"]}.jpg")
								end
							
							when "Fusion Monster"
								event.channel.send_embed do |embed|
								embed.colour = 0x9115ee #purple
								embed.add_field name: "**#{atem[0]["name"]}**", value: "**Type :** #{atem[0]["type"]} \n **Attribute :** #{atem[0]["attribute"]} \n **Level :** #{atem[0]["level"]}"
								embed.add_field name: "[ #{atem[0]["race"]} / Fusion / Effect ]", value: "#{atem[0]["desc"]}"
								embed.add_field name: "ATK", value: "#{atem[0]["atk"]}", inline: true
								embed.add_field name: "DEF", value: "#{atem[0]["def"]}", inline: true
                    			embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{CONFIG.api_pict}#{atem[0]["id"]}.jpg")
								end
							
							when "Synchro Monster"
								event.channel.send_embed do |embed|
								embed.colour = 0xfcfcfc #white
								embed.add_field name: "**#{atem[0]["name"]}**", value: "**Type :** #{atem[0]["type"]} \n **Attribute :** #{atem[0]["attribute"]} \n **Level :** #{atem[0]["level"]}"
								embed.add_field name: "[ #{atem[0]["race"]} / Synchro / Effect ]", value: "#{atem[0]["desc"]}"
								embed.add_field name: "ATK", value: "#{atem[0]["atk"]}", inline: true
								embed.add_field name: "DEF", value: "#{atem[0]["def"]}", inline: true
                    			embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{CONFIG.api_pict}#{atem[0]["id"]}.jpg")
								end
							
							when "XYZ Monster"
								event.channel.send_embed do |embed|
								embed.colour = 0x252525 #black
								embed.add_field name: "**#{atem[0]["name"]}**", value: "**Type :** #{atem[0]["type"]} \n **Attribute :** #{atem[0]["attribute"]} \n **Level :** #{atem[0]["level"]}"
								embed.add_field name: "[ #{atem[0]["race"]} / XYZ / Effect ]", value: "#{atem[0]["desc"]}"
								embed.add_field name: "ATK", value: "#{atem[0]["atk"]}", inline: true
								embed.add_field name: "DEF", value: "#{atem[0]["def"]}", inline: true
                    			embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{CONFIG.api_pict}#{atem[0]["id"]}.jpg")
								end
							
							when "Pendulum Effect Monster"
								event.channel.send_embed do |embed|
								embed.colour = 0x84b870 #greenlight
								embed.add_field name: "**#{atem[0]["name"]}**", value: "**Type :** #{atem[0]["type"]} \n **Attribute :** #{atem[0]["attribute"]} \n **Level :** #{atem[0]["level"]}"
								embed.add_field name: "[ #{atem[0]["race"]} / Pendulum / Effect ]", value: "#{atem[0]["desc"]}"
								embed.add_field name: "ATK", value: "#{atem[0]["atk"]}", inline: true
								embed.add_field name: "DEF", value: "#{atem[0]["def"]}", inline: true
                    			embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{CONFIG.api_pict}#{atem[0]["id"]}.jpg")
								end
							
							when "Link Monster"
								event.channel.send_embed do |embed|
								embed.colour = 0x293cbd #blue
								embed.add_field name: "**#{atem[0]["name"]}**", value: "**Type :** #{atem[0]["type"]} \n **Attribute :** #{atem[0]["attribute"]}"
								embed.add_field name: "[ #{atem[0]["race"]} / Link / Effect ]", value: "#{atem[0]["desc"]}"
								embed.add_field name: "ATK", value: "#{atem[0]["atk"]}", inline: true
								embed.add_field name: "LINK", value: "-#{atem[0]["linkval"]}", inline: true
                    			embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{CONFIG.api_pict}#{atem[0]["id"]}.jpg")
								end

							when "Spell Card"
								event.channel.send_embed do |embed|
								embed.colour = 0x258b5c #green
								embed.add_field name: "**#{atem[0]["name"]}**", value: "**Type :** #{atem[0]["type"]} \n **Property :** #{atem[0]["race"]}"
								embed.add_field name: "Effect", value: "#{atem[0]["desc"]}"
                    			embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{CONFIG.api_pict}#{atem[0]["id"]}.jpg")
								end

							when "Trap Card"
								event.channel.send_embed do |embed|
								embed.colour = 0xc51a57 #pink
								embed.add_field name: "**#{atem[0]["name"]}**", value: "**Type :** #{atem[0]["type"]} \n **Property :** #{atem[0]["race"]}"
								embed.add_field name: "Effect", value: "#{atem[0]["desc"]}"
                    			embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{CONFIG.api_pict}#{atem[0]["id"]}.jpg")
								end
						end
				
					end
				else
				end
				

            end
	  

    end
end
