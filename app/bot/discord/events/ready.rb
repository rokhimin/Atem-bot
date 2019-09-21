module Bot::DiscordEvents
  module Ready
    extend Discordrb::EventContainer
    CONFIG = OpenStruct.new YAML.load_file 'config/config.yaml'
    ready do |event|
		case CONFIG.mode_discord
			when 'development'
      		event.bot.game = Bot::CONFIG.game_discord_development
			when 'production'
      		event.bot.game = Bot::CONFIG.game_discord_production
			else
      		event.bot.game = Bot::CONFIG.game_discord_development
		end
    end
  end
end
