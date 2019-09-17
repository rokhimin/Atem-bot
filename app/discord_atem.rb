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
	
	case CONFIG.mode_discord
		when 'development'

		  BOT_DEVELOPMENT = Discordrb::Commands::CommandBot.new(client_id: CONFIG.client_id_discord,
													token: CONFIG.token_discord,
													prefix: CONFIG.prefix_discord_development)

		  def self.load_modules(klass, path)
			new_module = Module.new
			const_set(klass.to_sym, new_module)
			Dir["app/discord/#{path}/*.rb"].each { |file| load file }
			new_module.constants.each do |mod|
			  BOT_DEVELOPMENT.include! new_module.const_get(mod)
			end
		  end

		  load_modules(:DiscordEvents, 'events')
		  load_modules(:DiscordCommands, 'commands')
		  BOT_DEVELOPMENT.run
		
		when 'production'
	
		  BOT_PRODUCTION = Discordrb::Commands::CommandBot.new(client_id: CONFIG.client_id_discord,
													token: CONFIG.token_discord,
													prefix: CONFIG.prefix_discord_production)

		  def self.load_modules(klass, path)
			new_module = Module.new
			const_set(klass.to_sym, new_module)
			Dir["app/discord/#{path}/*.rb"].each { |file| load file }
			new_module.constants.each do |mod|
			  BOT_PRODUCTION.include! new_module.const_get(mod)
			end
		  end

		  load_modules(:DiscordEvents, 'events')
		  load_modules(:DiscordCommands, 'commands')
		  BOT_PRODUCTION.run
		
		else
			puts 'SET mode_discord in /config/config.yaml'
		end
end
