require 'discordrb'
require 'ostruct'
require 'yaml'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'json'

module Bot
  Dir['src/discord/*.rb'].each { |mod| load mod }

  CONFIG = OpenStruct.new YAML.load_file 'config/config.yaml'

  BOT = Discordrb::Commands::CommandBot.new(client_id: CONFIG.client_id_discord,
                                            token: CONFIG.token_discord,
                                            prefix: CONFIG.prefix_discord)

  def self.load_modules(klass, path)
    new_module = Module.new
    const_set(klass.to_sym, new_module)
    Dir["app/discord/#{path}/*.rb"].each { |file| load file }
    new_module.constants.each do |mod|
      BOT.include! new_module.const_get(mod)
    end
  end

  load_modules(:DiscordEvents, 'events')
  load_modules(:DiscordCommands, 'commands')

  BOT.run
end
