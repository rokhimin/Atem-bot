module Bot::DiscordCommands
  module Eval
    extend Discordrb::Commands::CommandContainer
	  
    command(:eval, help_available: false) do |event, *code|
      break unless event.user.id == Bot::CONFIG.owner
      begin
        eval code.join(' ')
      rescue => e
        "An error occurred 😞 ```#{e}```"
      end
    end

    
  end
end
