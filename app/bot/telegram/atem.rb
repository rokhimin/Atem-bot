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
							 src = message.text.sub('/search ', '')
							 listsrc = message.text.sub('/searchlist ', '')
							
							case message.text
								
							 	# help,welcome
                when '/start', '/welcome', '/help'
                  bot.api.send_message(chat_id: message.chat.id, text: "#{General.help}", parse_mode: 'Markdown')
							 
							 	# information bot
                when '/info'
								 callback = [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Source code', url: "#{General.sourcecode}")
    ]
								 markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: callback)
                  bot.api.send_message(chat_id: message.chat.id, text: "#{General.info}", parse_mode: 'Markdown', reply_markup: markup)
								
							  # Tier duellinksmeta
                when '/duellinksmeta'
                  bot.api.send_message(chat_id: message.chat.id, text: "#{Duellinksmeta.message}", parse_mode: 'Markdown')
								
							  # search random card
                when '/random'
                  bot.api.send_message(chat_id: message.chat.id, text: "#{Random.message}", parse_mode: 'Markdown')
								
							  # search list search card
                when '/searchlist ' + listsrc
                  bot.api.send_message(chat_id: message.chat.id, text: "#{Searchlist.message(listsrc)}", parse_mode: 'Markdown')
							  # exception list search card
                when '/searchlist'
                  bot.api.send_message(chat_id: message.chat.id, text: "/searchlist <name card>", parse_mode: 'Markdown')
								
							  # search card
                when '/search ' + src
				  	  	  bot.api.send_photo(chat_id: message.chat.id, photo: "#{Pict.link(src)}")
									bot.api.send_message(chat_id: message.chat.id, text: "#{Search.message(src)}", parse_mode: 'Markdown')
							  # exception search card
                when '/search'
                  bot.api.send_message(chat_id: message.chat.id, text: "/search <name card>", parse_mode: 'Markdown')
								
								else
								# quick search card
									card = message.text
									temp1 = card.sub("::", "<begin:atem>")
									temp2 = temp1.sub("::", "<end:atem>")
									from = /(?<=<begin:atem>).+(?=<end:atem>)/.match(temp2)
									carry = "#{/<end:atem>/.match(temp2)}"
									checker = "<end:atem>"

									unless carry == checker
									else
										bot.api.send_photo(chat_id: message.chat.id, photo: "#{Pict.link(from)}")
										bot.api.send_message(chat_id: message.chat.id, text: "#{Search.message(from)}", parse_mode: 'Markdown')
									end
										
             		end
							
            end
            end
    end
end