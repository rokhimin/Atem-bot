module Bot::DiscordCommands
  module Dlmeta
    extend Discordrb::Commands::CommandContainer
    
    command(:dlmeta) do |event|
      begin
        
        user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"
        url_address = "https://www.duellinksmeta.com/tier-list"
        
        html_content = URI.open(url_address, "User-Agent" => user_agent).read
        doc = Nokogiri::HTML(html_content)
        
        script_tags = doc.css('script')
        
        tier_list_data = nil
        last_updated = "Tier List"
        
        script_tags.each do |script|
          script_content = script.text
          
          if script_content.include?('window.__NEXT_DATA__') && script_content.include?('tier-list')
            begin
              json_match = script_content.match(/window\.__NEXT_DATA__ = ({.*})/m)
              if json_match
                json_data = JSON.parse(json_match[1])
                
                if json_data && json_data['props'] && json_data['props']['pageProps']
                  props = json_data['props']['pageProps']
                  
                  if props['tierList']
                    tier_list_data = props['tierList']
                    last_updated = props['lastUpdated'] || props['updatedAt'] || "Tier List"
                  elsif props['dehydratedState'] && props['dehydratedState']['queries']
                    queries = props['dehydratedState']['queries']
                    queries.each do |query|
                      if query['state'] && query['state']['data']
                        if query['state']['data']['tierList']
                          tier_list_data = query['state']['data']['tierList']
                        elsif query['state']['data']['lastUpdated']
                          last_updated = query['state']['data']['lastUpdated']
                        end
                      end
                    end
                  end
                end
                
                break if tier_list_data
              end
            rescue JSON::ParserError => e
              next
            end
          end
        end
        
        if tier_list_data.nil?
          tiers_data = {}
          
          date_element = doc.css('.header-container h4, .tier-list-date, .last-updated, p.update-date').first
          last_updated = date_element ? date_element.text.strip : "Tier List"
          
          tier_sections = doc.css('.tierlist-row, .tier-container, [class*="tier-list_tier"]')
          
          if !tier_sections.empty?
            tier_sections.each_with_index do |section, index|
              tier_name_element = section.css('h2, h3, .tier-name, div[class*="tierHeader"]').first
              tier_name = tier_name_element ? tier_name_element.text.strip : "Tier #{index + 1}"
              
              decks = []
              deck_elements = section.css('.deck-name, .deck-title, [class*="deckTypeDisplay"], [class*="deckItem"]')
              
              if !deck_elements.empty?
                deck_elements.each do |deck_element|
                  deck_name = deck_element.text.strip
                  decks << deck_name unless deck_name.empty?
                end
              end
              
              tiers_data[tier_name] = decks.empty? ? ["Data tidak tersedia"] : decks
              
              break if index >= 2
            end
          end
        else
          tiers_data = {}
          
          if tier_list_data.is_a?(Array)
            tier_list_data.each_with_index do |tier, index|
              break if index >= 3
              
              tier_name = tier['name'] || "Tier #{index + 1}"
              decks = []
              
              if tier['decks'] && tier['decks'].is_a?(Array)
                tier['decks'].each do |deck|
                  deck_name = deck['name'] || deck['displayName'] || deck['deckType']
                  decks << deck_name if deck_name
                end
              end
              
              tiers_data[tier_name] = decks.empty? ? ["Data tidak tersedia"] : decks
            end
          elsif tier_list_data.is_a?(Hash) && tier_list_data['tiers']
            tier_list_data['tiers'].each_with_index do |tier, index|
              break if index >= 3 
              
              tier_name = tier['name'] || "Tier #{index + 1}"
              decks = []
              
              if tier['decks'] && tier['decks'].is_a?(Array)
                tier['decks'].each do |deck|
                  deck_name = deck['name'] || deck['displayName'] || deck['deckType']
                  decks << deck_name if deck_name
                end
              end
              
              tiers_data[tier_name] = decks.empty? ? ["Data tidak tersedia"] : decks
            end
          end
        end
        
        if tiers_data.empty?
          (1..3).each do |tier_num|
            tier_name = "Tier #{tier_num}"
            deck_elements = doc.css("[class*='tier-#{tier_num}'] [class*='deck'], [class*='tier#{tier_num}'] [class*='deck']")
            
            if deck_elements.empty?
              deck_elements = doc.css("[data-tier='#{tier_num}'] [class*='deck']")
            end
            
            decks = []
            deck_elements.each do |element|
              deck_name = element.text.strip
              decks << deck_name unless deck_name.empty?
            end
            
            tiers_data[tier_name] = decks.empty? ? ["Data tidak tersedia"] : decks
          end
        end
        
        tier_keys = tiers_data.keys
        
        tier_keys = tier_keys.sort_by do |k| 
          matches = k.scan(/\d+/)
          matches.empty? ? 999 : matches.first.to_i
        end
        
        while tier_keys.length < 3
          next_tier = "Tier #{tier_keys.length + 1}"
          tier_keys << next_tier
          tiers_data[next_tier] = ["Data tidak tersedia"]
        end
        
        event.channel.send_embed do |embed|
          embed.colour = 0xff8040 
          embed.title = "Yu-Gi-Oh! Duel Links Tier List"
          embed.description = "Last Updated: #{last_updated}"
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Source: DuelLinksMeta.com")
          
          tier_keys.slice(0, 3).each do |tier_name|
            tier_decks = tiers_data[tier_name]
            if tier_decks.length > 10
              tier_decks = tier_decks[0..9] + ["...and #{tier_decks.length - 10} more"]
            end
            embed.add_field(name: tier_name, value: tier_decks.join("\n"), inline: true)
          end
        end
        
      rescue OpenURI::HTTPError => e
        event.respond "Error: Tidak dapat mengakses website (#{e.message})"
      rescue StandardError => e
        event.respond "Error: #{e.message}\n#{e.backtrace.join("\n")}"
      end
    end
    
  end
end