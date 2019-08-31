require 'discordrb'
require 'ostruct'
require 'yaml'
require 'nokogiri'
require 'open-uri'
require 'net/http'

# The main bot module.
module Bot
  Dir['src/modules/*.rb'].each { |mod| load mod }

  CONFIG = OpenStruct.new YAML.load_file 'config/config.yaml'

  BOT = Discordrb::Commands::CommandBot.new(client_id: CONFIG.client_id,
                                            token: CONFIG.token,
                                            prefix: CONFIG.prefix)

  def self.load_modules(klass, path)
    new_module = Module.new
    const_set(klass.to_sym, new_module)
    Dir["app/modules/#{path}/*.rb"].each { |file| load file }
    new_module.constants.each do |mod|
      BOT.include! new_module.const_get(mod)
    end
  end

  load_modules(:DiscordEvents, 'events')
  load_modules(:DiscordCommands, 'commands')

  # Run the bot
  BOT.run
end
