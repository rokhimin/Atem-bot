module Bot::DiscordEvents
    module Mention
        extend Discordrb::EventContainer
             CONFIG = OpenStruct.new YAML.load_file 'config/config.yaml'
            mention do |event|
                event.respond "**`#{CONFIG.prefix}help` for commands**"
            end
    end
end