module Bot::DiscordEvents
  module Ready
    extend Discordrb::EventContainer
    ready do |event|
      event.bot.game = Bot::CONFIG.game_discord
    end
  end
end
