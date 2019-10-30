require_relative 'commands/general'
require_relative 'commands/random-card'

class Atem
    def self.starts
            Telegram::Bot::Client.run(TOKEN) do |bot|
            bot.listen do |message|

             case message.text
                when '/info'
                  bot.api.send_message(chat_id: message.chat.id, text: "#{General.info}")
                when '/random'
                  bot.api.send_message(chat_id: message.chat.id, text: "#{Random.message}", parse_mode: 'Markdown')
							 		bot.api.send_photo(chat_id: message.chat.id, photo: "#{Random.pict}")
             end
							
            end
            end
    end
end