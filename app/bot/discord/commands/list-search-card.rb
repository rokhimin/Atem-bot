module Bot::DiscordCommands
  module Listsrccard
    extend Discordrb::Commands::CommandContainer
    
    # Number emojis that Discord recognizes for reactions
    NUMBER_EMOJIS = ['1️⃣', '2️⃣', '3️⃣', '4️⃣', '5️⃣', '6️⃣', '7️⃣', '8️⃣', '9️⃣', '🔟']
    MAX_RESULTS = 10  # Limiting to 10 results for reactions to work properly
    EMBED_COLOR = 0xff8040  # Orange
    
    command(:src) do |event, *from|
      search_term = from.join(' ')
      search_results = perform_search(search_term)
      
      if search_results.empty?
        send_no_results_embed(event, search_term)
      else
        message = send_results_embed(event, search_term, search_results)
        add_reaction_numbers(message, search_results.length)
        
        # Setup reaction handler
        setup_reaction_handler(event, message, search_results)
      end
    end
    
    private
    
    def self.perform_search(search_term)
      results = []
      
      begin
        search_list = Ygoprodeck::List.is(search_term)
        
        # Check if we have valid results
        return [] if search_list.nil? || search_list.empty? || search_list[0]['id'].nil?
        
        # Get up to MAX_RESULTS
        search_list.first(MAX_RESULTS).each do |card|
          results << card if card && card["name"]
        end
      rescue => e
        puts "Error searching for cards: #{e.message}"
      end
      
      results
    end
    
    def self.send_no_results_embed(event, search_term)
      event.channel.send_embed do |embed|
        embed.colour = EMBED_COLOR
        embed.add_field(
          name: "0 card matches for ``#{search_term}``", 
          value: "Try again aibou..", 
          inline: true
        )
      end
    end
    
    def self.send_results_embed(event, search_term, results)
      # Create numbered list for display
      card_list = []
      results.each_with_index do |card, index|
        # Use regular numbers for display (simpler)
        number = index + 1
        number_str = number == 10 ? "0" : number.to_s
        card_list << "#{number_str}. #{card['name']}"
      end
      
      event.channel.send_embed do |embed|
        embed.colour = EMBED_COLOR
        embed.add_field(
          name: "#{results.length} card matches for ``#{search_term}``", 
          value: card_list.join("\n"),
          inline: true
        )
        embed.footer = Discordrb::Webhooks::EmbedFooter.new(
          text: "React with a number to see details for that card"
        )
      end
    end
    
    def self.add_reaction_numbers(message, count)
      # Add reaction numbers based on result count (up to MAX_RESULTS)
      count = [count, MAX_RESULTS].min
      
      begin
        count.times do |i|
          begin
            # Instead of fancy emojis, try using Discord reaction codes
            # These are the actual emoji IDs that Discord understands
            case i
            when 0
              message.react("1\u20e3") # 1️⃣
            when 1
              message.react("2\u20e3") # 2️⃣
            when 2
              message.react("3\u20e3") # 3️⃣
            when 3
              message.react("4\u20e3") # 4️⃣
            when 4
              message.react("5\u20e3") # 5️⃣
            when 5
              message.react("6\u20e3") # 6️⃣
            when 6
              message.react("7\u20e3") # 7️⃣
            when 7
              message.react("8\u20e3") # 8️⃣
            when 8
              message.react("9\u20e3") # 9️⃣
            when 9
              message.react("0\u20e3") # 0️⃣ (for number 10)
            end
            
            # Add a small delay to prevent rate limiting
            sleep(0.5)
          rescue => e
            puts "Failed to add reaction #{i+1}: #{e.message}"
          end
        end
      rescue => e
        puts "Error in reaction setup: #{e.message}"
      end
    end
    
    def self.setup_reaction_handler(event, message, results)
      # Create a reaction handler that will last for 5 minutes
      event.bot.add_await!(
        Discordrb::Events::ReactionAddEvent,
        timeout: 300,
        message: message.id
      ) do |reaction_event|
        # Skip if bot's own reaction or if from another user
        next true if reaction_event.user.bot_account
        next true if reaction_event.user.id != event.user.id
        
        # Find which number was reacted with
        reaction = reaction_event.emoji.name
        
        # Handle the keycap numbers (e.g., "1⃣")
        index = nil
        if reaction.match(/^[0-9]\u20e3$/)
          num = reaction[0].to_i
          index = num == 0 ? 9 : num - 1  # 0 is for the 10th item
        end
        
        # If valid reaction and within our results range
        if index && index < results.length
          selected_card = results[index]
          display_card_details(event, selected_card)
        end
        
        # Continue awaiting reactions
        false
      end
    end
    
    def self.display_card_details(event, card)
      # Get full card details
      begin
        card_id = card["id"]
        card_data = Ygoprodeck::Fname.is(card["name"])
        
        if card_data && card_data["id"]
          # Use the existing display methods from Bot::DiscordCommands::Searchcard
          # This assumes your Searchcard module has been refactored with display_card method
          if defined?(Bot::DiscordCommands::Searchcard.display_card)
            Bot::DiscordCommands::Searchcard.display_card(event, card_data)
          else
            # Fallback if Searchcard module isn't available
            event.channel.send_message("Found card: #{card['name']} (ID: #{card_id})")
          end
        else
          event.channel.send_message("Could not find detailed information for #{card['name']}")
        end
      rescue => e
        event.channel.send_message("Error fetching card details: #{e.message}")
      end
    end
  end
end