require_relative 'commands/general'
require_relative 'commands/random-card'
require_relative 'commands/search-card'
require_relative 'commands/search-list'
require_relative 'commands/search-pict-card'
require_relative 'commands/duellinksmeta'

class Atem
  def self.starts
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.listen do |message|
        text = message.text.to_s.strip

        case text
        when '/start', '/welcome', '/help'
          bot.api.send_message(chat_id: message.chat.id, text: General.help, parse_mode: 'Markdown')

        when '/info'
          callback = [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Source code', url: General.sourcecode)
          ]
          markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: [callback])
          bot.api.send_message(chat_id: message.chat.id, text: General.info, parse_mode: 'Markdown', reply_markup: markup)

        when '/random'
          bot.api.send_message(chat_id: message.chat.id, text: Random.message, parse_mode: 'Markdown')

        when '/search'
          bot.api.send_message(chat_id: message.chat.id, text: "/search <name card>", parse_mode: 'Markdown')

        when '/searchlist'
          bot.api.send_message(chat_id: message.chat.id, text: "/searchlist <name card>", parse_mode: 'Markdown')

        else
          if text.start_with?('/search ')
            keyword = text.sub('/search ', '')
            bot.api.send_photo(chat_id: message.chat.id, photo: Pict.link(keyword))
            bot.api.send_message(chat_id: message.chat.id, text: Search.message(keyword), parse_mode: 'Markdown')

          elsif text.start_with?('/searchlist ')
            keyword = text.sub('/searchlist ', '')
            bot.api.send_message(chat_id: message.chat.id, text: Searchlist.message(keyword), parse_mode: 'Markdown')

          elsif text.include?('::')
            temp1 = text.sub('::', '<begin:atem>')
            temp2 = temp1.sub('::', '<end:atem>')
            from = /(?<=<begin:atem>).+(?=<end:atem>)/.match(temp2)
            if from
              bot.api.send_photo(chat_id: message.chat.id, photo: Pict.link(from.to_s))
              bot.api.send_message(chat_id: message.chat.id, text: Search.message(from.to_s), parse_mode: 'Markdown')
            end

          end
        end
      end
    end
  end
end
