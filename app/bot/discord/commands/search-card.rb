module Bot::DiscordCommands
  module Searchcard 
    extend Discordrb::EventContainer
    
    MONSTER_TYPES = {
      "Normal Monster" => { color: 0xdac14c, suffix: "" },
      "Normal Tuner Monster" => { color: 0xdac14c, suffix: "/ Tuner" },
      "Effect Monster" => { color: 0xa87524, suffix: "/ Effect" },
      "Flip Effect Monster" => { color: 0xa87524, suffix: "/ Flip / Effect" },
      "Flip Tuner Effect Monster" => { color: 0xa87524, suffix: "/ Flip / Tuner / Effect" },
      "Tuner Monster" => { color: 0xa87524, suffix: "/ Tuner / Effect" },
      "Toon Monster" => { color: 0xa87524, suffix: "/ Toon / Effect" },
      "Gemini Monster" => { color: 0xa87524, suffix: "/ Gemini / Effect" },
      "Spirit Monster" => { color: 0xa87524, suffix: "/ Spirit / Effect" },
      "Union Effect Monster" => { color: 0xa87524, suffix: "/ Union / Effect" },
      "Union Tuner Effect Monster" => { color: 0xa87524, suffix: "/ Union / Tuner / Effect" },
      "Ritual Monster" => { color: 0x293cbd, suffix: "/ Ritual" },
      "Ritual Effect Monster" => { color: 0x293cbd, suffix: "/ Ritual / Effect" },
      "Fusion Monster" => { color: 0x9115ee, suffix: "/ Fusion / Effect" },
      "Synchro Monster" => { color: 0xfcfcfc, suffix: "/ Synchro / Effect" },
      "Synchro Pendulum Effect Monster" => { color: 0xfcfcfc, suffix: "/ Synchro / Pendulum / Effect" },
      "Synchro Tuner Monster" => { color: 0xfcfcfc, suffix: "/ Synchro / Tuner / Effect" },
      "XYZ Monster" => { color: 0x252525, suffix: "/ XYZ / Effect" },
      "XYZ Pendulum Effect Monster" => { color: 0x252525, suffix: "/ XYZ / Pendulum / Effect" },
      "Pendulum Effect Monster" => { color: 0x84b870, suffix: "/ Pendulum / Effect" },
      "Pendulum Flip Effect Monster" => { color: 0x84b870, suffix: "/ Pendulum / Flip / Effect" },
      "Pendulum Normal Monster" => { color: 0x84b870, suffix: "/ Pendulum" },
      "Pendulum Tuner Effect Monster" => { color: 0x84b870, suffix: "/ Pendulum / Tuner / Effect" },
      "Pendulum Effect Fusion Monster" => { color: 0x84b870, suffix: "/ Pendulum / Effect / Fusion" },
      "Link Monster" => { color: 0x293cbd, suffix: "/ Link / Effect" }
    }
    
    NON_MONSTER_TYPES = {
      "Spell Card" => { color: 0x258b5c },
      "Trap Card" => { color: 0xc51a57 },
      "Skill Card" => { color: 0x252525 }
    }
    
    NOT_FOUND_IMAGE = "https://i.imgur.com/lPSo3Tt.jpg"

    message(description: 'searchcard') do |event|
      content = event.message.content
      
      # Check if content contains the pattern ::text::
      if content.include?('::')
        # Extract content between :: markers similar to the original code
        temp1 = content.sub("::", "<begin:atem>")
        temp2 = temp1.sub("::", "<end:atem>")
        
        # Find match between markers
        match = /<begin:atem>(.+?)<end:atem>/.match(temp2)
        carry = temp2.include?("<end:atem>") ? "<end:atem>" : nil
        
        # Only proceed if proper format is found
        if match && carry == "<end:atem>"
          card_name = match[1]
          begin
            card_data = Ygoprodeck::Fname.is(card_name)
            
            if card_data.nil? || card_data["id"].nil?
              # Card not found
              send_not_found_embed(event, card_name)
            else
              # Card found
              send_card_embed(event, card_data)
            end
          rescue => e
  			    puts "[ERROR_API : #{Time.now}]#{e.message}"
            send_not_found_embed(event, card_name)
          end
        end
      end
    end
    
    private
    
    def self.send_not_found_embed(event, card_name)
      
    with_message = <<~CONTEXT
    cari kartu yugioh bernama #{card_name}, jika tidak ada tolong perbaiki nama nya agar mendekati nama kartu yugioh yang ada di database!
    CONTEXT

    # API endpoint from Gemini 
    api_key = ENV['gemini_api_key']
    uri = URI.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=#{api_key}")
    
    # Request data
    request_data = {
      contents: [{
        parts: [{ text: with_message }]
      }]
    }
    
    # Make HTTP request
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' => 'application/json'})
    request.body = request_data.to_json
    
    response = http.request(request)
    
    if response.code == "200"
      result = JSON.parse(response.body)
      
      # Extract response text
      bot_response = "I'm sorry, I couldn't process your request."
      
      if result && 
         result["candidates"] && 
         result["candidates"][0] && 
         result["candidates"][0]["content"] && 
         result["candidates"][0]["content"]["parts"] && 
         result["candidates"][0]["content"]["parts"][0]
        bot_response = result["candidates"][0]["content"]["parts"][0]["text"]
        match_answer = bot_response.match(/^(.+?\n\n){1,4}/m)
      end

    end
      event.channel.send_embed do |embed|
        embed.colour = 0xff1432
        embed.description = "**'#{card_name}' not found**"
        embed.image = Discordrb::Webhooks::EmbedImage.new(url: NOT_FOUND_IMAGE)
        embed.add_field name: "[AI Help]", value: match_answer
      end
    end
    
    def self.send_card_embed(event, card_data)
      return if card_data.nil?
      
      id = card_data["id"]
      name = card_data["name"]
      type = card_data["type"]
      
      if is_monster_card?(type)
        send_monster_embed(event, card_data)
      else
        send_non_monster_embed(event, card_data)
      end
    end
    
    def self.is_monster_card?(type)
      MONSTER_TYPES.key?(type)
    end
    
    def self.send_monster_embed(event, card_data)
      id = card_data["id"]
      name = card_data["name"]
      type = card_data["type"]
      attribute = card_data["attribute"]
      level = card_data["level"]
      race = card_data["race"]
      desc = card_data["desc"]
      atk = card_data["atk"]
      def_val = card_data["def"]
      pict = Ygoprodeck::Image.is(id)
      
      type_info = MONSTER_TYPES[type]
      about = "[ #{race} #{type_info[:suffix]} ]"
      
      event.channel.send_embed do |embed|
        embed.colour = type_info[:color]
        embed.add_field name: "**#{name}**", value: "**Type:** #{type}\n**Attribute:** #{attribute}\n**Level:** #{level}"
        embed.add_field name: about, value: desc
        embed.add_field name: "ATK", value: atk.to_s, inline: true
        embed.add_field name: "DEF", value: def_val.to_s, inline: true
        embed.image = Discordrb::Webhooks::EmbedImage.new(url: pict)
      end
    end
    
    def self.send_non_monster_embed(event, card_data)
      id = card_data["id"]
      name = card_data["name"]
      type = card_data["type"]
      race = card_data["race"]
      desc = card_data["desc"]
      pict = Ygoprodeck::Image.is(id)
      
      event.channel.send_embed do |embed|
        embed.colour = NON_MONSTER_TYPES[type][:color]
        embed.add_field name: "**#{name}**", value: "**Type:** #{type}\n**Property:** #{race}"
        embed.add_field name: "Effect", value: desc
        embed.image = Discordrb::Webhooks::EmbedImage.new(url: pict)
      end
    end
  end
end