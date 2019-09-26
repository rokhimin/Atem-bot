module Bot::DiscordCommands
  module Randomcard
    extend Discordrb::Commands::CommandContainer
	  
		CONFIG = OpenStruct.new YAML.load_file 'config/config.yaml'
	
	  	command(:random) do |event|
			url = "#{CONFIG.api_rand}"
			uri = URI(url)
			response = Net::HTTP.get(uri)
			atem = JSON.parse(response)
			
			id = atem[0]["id"]
			name = atem[0]["name"]
			type = atem[0]["type"]
			attribute = atem[0]["attribute"]
			level = atem[0]["level"]
			race = atem[0]["race"]
			desc = atem[0]["desc"]
			m_atk = atem[0]["atk"]
			m_def = atem[0]["def"]
			about = []
			pict = "#{CONFIG.api_pict}#{id}.jpg"
			
				case type
					when "Normal Monster"
						about << "[ #{race} ]"	 
						color = 0xdac14c
							
					when "Normal Tuner Monster"
						about << "[ #{race} / Tuner ]"
						color = 0xdac14c
					
					when "Effect Monster"
						about << "[ #{race} / Effect ]"
						color = 0xa87524
							
					when "Flip Effect Monster"
						about << "[ #{race} / Flip / Effect ]"
						color = 0xa87524
							
					when "Flip Tuner Effect Monster"
						about << "[ #{race} / Flip / Tuner / Effect ]"
						color = 0xa87524
							
					when "Tuner Monster"
						about << "[ #{race} / Tuner / Effect ]"
						color = 0xa87524
							
					when "Toon Monster"
						about << "[ #{race} / Toon / Effect ]"
						color = 0xa87524
							
					when "Gemini Monster"
						about << "[ #{race} / Gemini / Effect ]"
						color = 0xa87524
							
					when "Spirit Monster"
						about << "[ #{race} / Spirit / Effect ]"
						color = 0xa87524
							
					when "Union Effect Monster"
						about << "[ #{race} / Union / Effect ]"
						color = 0xa87524
							
					when "Union Tuner Effect Monster"
						about << "[ #{race} / Union / Tuner / Effect ]"
						color = 0xa87524
							
					when "Ritual Monster"
						about << "[ #{race} / Ritual ]"
						color = 0x293cbd 
							
					when "Ritual Effect Monster"
						about << "[ #{race} / Ritual / Effect ]"
						color = 0x293cbd
							
					when "Fusion Monster"
						about << "[ #{race} / Fusion / Effect ]"
						color = 0x9115ee
							
					when "Synchro Monster"
						about << "[ #{race} / Synchro / Effect ]"
						color = 0xfcfcfc
							
					when "Synchro Pendulum Effect Monster"
						about << "[ #{race} / Synchro / Pendulum / Effect ]"
						color = 0xfcfcfc
							
					when "Synchro Tuner Monster"
						about << "[ #{race} / Synchro / Tuner / Effect ]"
						color = 0xfcfcfc
							
					when "XYZ Monster"
						about << "[ #{race} / XYZ / Effect ]"
						color = 0x252525
							
					when "XYZ Pendulum Effect Monster"
						about << "[ #{race} / XYZ / Pendulum / Effect ]"
						color = 0x252525
							
					when "Pendulum Effect Monster"
						about << "[ #{race} / Pendulum / Effect ]"
						color = 0x84b870
							
					when "Pendulum Flip Effect Monster"
						about << "[ #{race} / Pendulum / Flip / Effect ]"
						color = 0x84b870
							
					when "Pendulum Normal Monster"
						about << "[ #{race} / Pendulum ]"
						color = 0x84b870
							
					when "Pendulum Tuner Effect Monster"
						about << "[ #{race} / Pendulum / Tuner / Effect ]"
						color = 0x84b870
							
					when "Pendulum Effect Fusion Monster"
						about << "[ #{race} / Pendulum / Effect / Fusion ]"
						color = 0x84b870
							
					when "Link Monster"
						about << "[ #{race} / Link / Effect ]"
						color = 0x293cbd

					when "Spell Card"
						color = 0x258b5c

					when "Trap Card"
						color = 0xc51a57

					when "Skill Card"
						color = 0x252525
							
				end
				
				case type
					when "Normal Monster", 
						"Normal Tuner Monster", 
						"Effect Monster", 
						"Flip Effect Monster", 
						"Flip Tuner Effect Monster", 
						"Tuner Monster", 
						"Toon Monster", 
						"Gemini Monster", 
						"Spirit Monster", 
						"Union Effect Monster", 
						"Union Tuner Effect Monster", 
						"Ritual Monster", 
						"Ritual Effect Monster", 
						"Fusion Monster", 
						"Synchro Monster", 
						"Synchro Pendulum Effect Monster", 
						"Synchro Tuner Monster", 
						"XYZ Monster", 
						"XYZ Pendulum Effect Monster", 
						"Pendulum Effect Monster", 
						"Pendulum Flip Effect Monster", 
						"Pendulum Normal Monster", 
						"Pendulum Tuner Effect Monster", 
						"Pendulum Effect Fusion Monster", 
						"Link Monster"
						
						event.channel.send_embed do |embed|
							embed.colour = color
							embed.add_field name: "**#{name}**", value: "**Type :** #{type} \n **Attribute :** #{attribute} \n **Level :** #{level}"
							embed.add_field name: "#{about.join('')}", value: "#{desc}"
							embed.add_field name: "ATK", value: "#{m_atk}", inline: true
							embed.add_field name: "DEF", value: "#{m_def}", inline: true
                    		embed.image = Discordrb::Webhooks::EmbedImage.new(url: pict)
						end

					when "Spell Card", 
						"Trap Card", 
						"Skill Card"
						
						event.channel.send_embed do |embed|
							embed.colour = color
							embed.add_field name: "**#{name}**", value: "**Type :** #{type} \n **Property :** #{race}"
							embed.add_field name: "Effect", value: "#{desc}"
                    		embed.image = Discordrb::Webhooks::EmbedImage.new(url: pict)
						end
					
					end

            end
	  

    
  end
end
