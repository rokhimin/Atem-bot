module Bot::DiscordEvents
  module Ready
    extend Discordrb::EventContainer

    ready do |event|
      case ENV['mode_discord']
      when 'development'
        event.bot.game = ENV['game_discord_development']
      when 'production'
        event.bot.game = ENV['game_discord_production']
      else
        event.bot.game = ENV['game_discord_development']
      end
    end
  end
end
