module Bot::DiscordEvents
  module Mention
    extend Discordrb::EventContainer
    mention do |event|
      case ENV['mode_discord']
      when 'development'
        event.respond "**`#{ENV['prefix_discord_development']}help` for usage**"
      when 'production'
        event.respond "**`#{ENV['prefix_discord_production']}help` for usage**"
      else
        event.respond "**`#{ENV['prefix_discord_development']}help` for usage**"
      end
    end
  end
end
