module Bot::DiscordCommands
  module Randomcard
    extend Discordrb::Commands::CommandContainer

    MONSTER_TYPES = {
      'Normal Monster' => {
        color: 0xdac14c,
        suffix: ''
      },
      'Normal Tuner Monster' => {
        color: 0xdac14c,
        suffix: '/ Tuner'
      },
      'Effect Monster' => {
        color: 0xa87524,
        suffix: '/ Effect'
      },
      'Flip Effect Monster' => {
        color: 0xa87524,
        suffix: '/ Flip / Effect'
      },
      'Flip Tuner Effect Monster' => {
        color: 0xa87524,
        suffix: '/ Flip / Tuner / Effect'
      },
      'Tuner Monster' => {
        color: 0xa87524,
        suffix: '/ Tuner / Effect'
      },
      'Toon Monster' => {
        color: 0xa87524,
        suffix: '/ Toon / Effect'
      },
      'Gemini Monster' => {
        color: 0xa87524,
        suffix: '/ Gemini / Effect'
      },
      'Spirit Monster' => {
        color: 0xa87524,
        suffix: '/ Spirit / Effect'
      },
      'Union Effect Monster' => {
        color: 0xa87524,
        suffix: '/ Union / Effect'
      },
      'Union Tuner Effect Monster' => {
        color: 0xa87524,
        suffix: '/ Union / Tuner / Effect'
      },
      'Ritual Monster' => {
        color: 0x293cbd,
        suffix: '/ Ritual'
      },
      'Ritual Effect Monster' => {
        color: 0x293cbd,
        suffix: '/ Ritual / Effect'
      },
      'Fusion Monster' => {
        color: 0x9115ee,
        suffix: '/ Fusion / Effect'
      },
      'Synchro Monster' => {
        color: 0xfcfcfc,
        suffix: '/ Synchro / Effect'
      },
      'Synchro Pendulum Effect Monster' => {
        color: 0xfcfcfc,
        suffix: '/ Synchro / Pendulum / Effect'
      },
      'Synchro Tuner Monster' => {
        color: 0xfcfcfc,
        suffix: '/ Synchro / Tuner / Effect'
      },
      'XYZ Monster' => {
        color: 0x252525,
        suffix: '/ XYZ / Effect'
      },
      'XYZ Pendulum Effect Monster' => {
        color: 0x252525,
        suffix: '/ XYZ / Pendulum / Effect'
      },
      'Pendulum Effect Monster' => {
        color: 0x84b870,
        suffix: '/ Pendulum / Effect'
      },
      'Pendulum Flip Effect Monster' => {
        color: 0x84b870,
        suffix: '/ Pendulum / Flip / Effect'
      },
      'Pendulum Normal Monster' => {
        color: 0x84b870,
        suffix: '/ Pendulum'
      },
      'Pendulum Tuner Effect Monster' => {
        color: 0x84b870,
        suffix: '/ Pendulum / Tuner / Effect'
      },
      'Pendulum Effect Fusion Monster' => {
        color: 0x84b870,
        suffix: '/ Pendulum / Effect / Fusion'
      },
      'Link Monster' => {
        color: 0x293cbd,
        suffix: '/ Link / Effect'
      }
    }

    NON_MONSTER_TYPES = {
      'Spell Card' => {
        color: 0x258b5c
      },
      'Trap Card' => {
        color: 0xc51a57
      },
      'Skill Card' => {
        color: 0x252525
      }
    }

    command(:random) do |event|
      begin
        card_data = Ygoprodeck::Card.random
        display_card(event, card_data)
      rescue => e
        event.channel.send_message("Error fetching random card: #{e.message}")
      end
    end

    private

    def self.display_card(event, card_data)
      return if card_data.nil?

      type = card_data['type']

      if is_monster_card?(type)
        display_monster_card(event, card_data)
      else
        display_non_monster_card(event, card_data)
      end
    end

    def self.is_monster_card?(type)
      MONSTER_TYPES.key?(type)
    end

    def self.display_monster_card(event, card_data)
      id = card_data['id']
      name = card_data['name']
      type = card_data['type']
      attribute = card_data['attribute']
      level = card_data['level']
      race = card_data['race']
      desc = card_data['desc']
      atk = card_data['atk']
      def_val = card_data['def']
      pict = Ygoprodeck::Image.is(id)

      type_info = MONSTER_TYPES[type]
      about = "[ #{race} #{type_info[:suffix]} ]"

      event.channel.send_embed do |embed|
        embed.colour = type_info[:color]
        embed.add_field name: "**#{name}**",
                        value:
                          "**Type:** #{type}\n**Attribute:** #{attribute}\n**Level:** #{level}"
        embed.add_field name: about, value: desc
        embed.add_field name: 'ATK', value: atk.to_s, inline: true
        embed.add_field name: 'DEF', value: def_val.to_s, inline: true
        embed.image = Discordrb::Webhooks::EmbedImage.new(url: pict)
      end
    end

    def self.display_non_monster_card(event, card_data)
      id = card_data['id']
      name = card_data['name']
      type = card_data['type']
      race = card_data['race']
      desc = card_data['desc']
      pict = Ygoprodeck::Image.is(id)

      event.channel.send_embed do |embed|
        embed.colour = NON_MONSTER_TYPES[type][:color]
        embed.add_field name: "**#{name}**",
                        value: "**Type:** #{type}\n**Property:** #{race}"
        embed.add_field name: 'Effect', value: desc
        embed.image = Discordrb::Webhooks::EmbedImage.new(url: pict)
      end
    end
  end
end
