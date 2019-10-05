require_relative 'commands/general'

class Atem
    def self.starts
            Telegram::Bot::Client.run(TOKEN) do |bot|
            bot.listen do |message|

             case message.text
                when '/info'
                  bot.api.send_message(chat_id: message.chat.id, text: "#{General.info}")
             end
            end
            end
    end
end