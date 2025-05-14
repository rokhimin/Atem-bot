require_relative 'commands/general'
require_relative 'commands/random-card'
require_relative 'commands/search-card'
require_relative 'commands/search-list'
require_relative 'commands/search-pict-card'

class Atem
  # Constant untuk prefiks perintah
  COMMAND_PREFIX = '/'.freeze
  
  # Command patterns
  COMMANDS = {
    start: ['/start', '/welcome', '/help'],
    info: ['/info'],
    random: ['/random'],
    search: ['/search'],
    searchlist: ['/searchlist']
  }.freeze

  def self.starts
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.listen do |message|
        # Skip non-Message objects
        next unless message.is_a?(Telegram::Bot::Types::Message)
        
        text = message.text.to_s.strip
        
        handle_message(bot, message, text)
      end
    end
  end
  
  private
  
  def self.handle_message(bot, message, text)
    chat_id = message.chat.id
    
    case
    when COMMANDS[:start].include?(text)
      send_message(bot, chat_id, General.help)
      
    when COMMANDS[:info].include?(text)
      send_info_message(bot, chat_id)
      
    when COMMANDS[:random].include?(text)
      send_message(bot, chat_id, Random.message)
      
    when COMMANDS[:search].include?(text)
      send_message(bot, chat_id, "/search <name card>")
      
    when COMMANDS[:searchlist].include?(text)
      send_message(bot, chat_id, "/searchlist <name card>")
      
    when text.start_with?("#{COMMANDS[:search][0]} ")
      handle_search(bot, chat_id, text.sub("#{COMMANDS[:search][0]} ", ''))
      
    when text.start_with?("#{COMMANDS[:searchlist][0]} ")
      handle_searchlist(bot, chat_id, text.sub("#{COMMANDS[:searchlist][0]} ", ''))
      
    when text.include?('::')
      handle_shorthand_search(bot, chat_id, text)
    end
  end
  
  def self.send_message(bot, chat_id, text, parse_mode = 'Markdown')
    bot.api.send_message(chat_id: chat_id, text: text, parse_mode: parse_mode)
  end
  
  def self.send_info_message(bot, chat_id)
    callback = [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Source code', url: General.sourcecode)
    ]
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: [callback])
    
    bot.api.send_message(
      chat_id: chat_id, 
      text: General.info, 
      parse_mode: 'Markdown', 
      reply_markup: markup
    )
  end
  
  def self.handle_search(bot, chat_id, keyword)
    bot.api.send_photo(chat_id: chat_id, photo: Pict.link(keyword))
    send_message(bot, chat_id, Search.message(keyword))
  end
  
  def self.handle_searchlist(bot, chat_id, keyword)
    send_message(bot, chat_id, Searchlist.message(keyword))
  end
  
  def self.handle_shorthand_search(bot, chat_id, text)
    # Menggunakan regex yang lebih bersih
    if match = text.match(/::(.+)::/)
      keyword = match[1]
      handle_search(bot, chat_id, keyword)
    end
  end
end