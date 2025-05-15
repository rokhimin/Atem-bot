class Search
  # Monster types constants for better organization
  MONSTER_TYPES = [
    'Normal Monster',
    'Normal Tuner Monster',
    'Effect Monster',
    'Flip Effect Monster',
    'Flip Tuner Effect Monster',
    'Tuner Monster',
    'Toon Monster',
    'Gemini Monster',
    'Spirit Monster',
    'Union Effect Monster',
    'Union Tuner Effect Monster',
    'Ritual Monster',
    'Ritual Effect Monster',
    'Fusion Monster',
    'Synchro Monster',
    'Synchro Pendulum Effect Monster',
    'Synchro Tuner Monster',
    'XYZ Monster',
    'XYZ Pendulum Effect Monster',
    'Pendulum Effect Monster',
    'Pendulum Flip Effect Monster',
    'Pendulum Normal Monster',
    'Pendulum Tuner Effect Monster',
    'Pendulum Effect Fusion Monster',
    'Link Monster'
  ].freeze

  NON_MONSTER_TYPES = ['Spell Card', 'Trap Card', 'Skill Card'].freeze

  # Color mapping by type
  TYPE_COLORS = {
    'Normal Monster' => 0xdac14c,
    'Normal Tuner Monster' => 0xdac14c,
    'Effect Monster' => 0xa87524,
    'Flip Effect Monster' => 0xa87524,
    'Flip Tuner Effect Monster' => 0xa87524,
    'Tuner Monster' => 0xa87524,
    'Toon Monster' => 0xa87524,
    'Gemini Monster' => 0xa87524,
    'Spirit Monster' => 0xa87524,
    'Union Effect Monster' => 0xa87524,
    'Union Tuner Effect Monster' => 0xa87524,
    'Ritual Monster' => 0x293cbd,
    'Ritual Effect Monster' => 0x293cbd,
    'Fusion Monster' => 0x9115ee,
    'Synchro Monster' => 0xfcfcfc,
    'Synchro Pendulum Effect Monster' => 0xfcfcfc,
    'Synchro Tuner Monster' => 0xfcfcfc,
    'XYZ Monster' => 0x252525,
    'XYZ Pendulum Effect Monster' => 0x252525,
    'Pendulum Effect Monster' => 0x84b870,
    'Pendulum Flip Effect Monster' => 0x84b870,
    'Pendulum Normal Monster' => 0x84b870,
    'Pendulum Tuner Effect Monster' => 0x84b870,
    'Pendulum Effect Fusion Monster' => 0x84b870,
    'Link Monster' => 0x293cbd,
    'Spell Card' => 0x258b5c,
    'Trap Card' => 0xc51a57,
    'Skill Card' => 0x252525
  }.freeze

  # Type description mapping
  TYPE_DESCRIPTIONS = {
    'Normal Monster' => lambda { |race| "[ #{race} ]" },
    'Normal Tuner Monster' => lambda { |race| "[ #{race} / Tuner ]" },
    'Effect Monster' => lambda { |race| "[ #{race} / Effect ]" },
    'Flip Effect Monster' => lambda { |race| "[ #{race} / Flip / Effect ]" },
    'Flip Tuner Effect Monster' =>
      lambda { |race| "[ #{race} / Flip / Tuner / Effect ]" },
    'Tuner Monster' => lambda { |race| "[ #{race} / Tuner / Effect ]" },
    'Toon Monster' => lambda { |race| "[ #{race} / Toon / Effect ]" },
    'Gemini Monster' => lambda { |race| "[ #{race} / Gemini / Effect ]" },
    'Spirit Monster' => lambda { |race| "[ #{race} / Spirit / Effect ]" },
    'Union Effect Monster' => lambda { |race| "[ #{race} / Union / Effect ]" },
    'Union Tuner Effect Monster' =>
      lambda { |race| "[ #{race} / Union / Tuner / Effect ]" },
    'Ritual Monster' => lambda { |race| "[ #{race} / Ritual ]" },
    'Ritual Effect Monster' =>
      lambda { |race| "[ #{race} / Ritual / Effect ]" },
    'Fusion Monster' => lambda { |race| "[ #{race} / Fusion / Effect ]" },
    'Synchro Monster' => lambda { |race| "[ #{race} / Synchro / Effect ]" },
    'Synchro Pendulum Effect Monster' =>
      lambda { |race| "[ #{race} / Synchro / Pendulum / Effect ]" },
    'Synchro Tuner Monster' =>
      lambda { |race| "[ #{race} / Synchro / Tuner / Effect ]" },
    'XYZ Monster' => lambda { |race| "[ #{race} / XYZ / Effect ]" },
    'XYZ Pendulum Effect Monster' =>
      lambda { |race| "[ #{race} / XYZ / Pendulum / Effect ]" },
    'Pendulum Effect Monster' =>
      lambda { |race| "[ #{race} / Pendulum / Effect ]" },
    'Pendulum Flip Effect Monster' =>
      lambda { |race| "[ #{race} / Pendulum / Flip / Effect ]" },
    'Pendulum Normal Monster' => lambda { |race| "[ #{race} / Pendulum ]" },
    'Pendulum Tuner Effect Monster' =>
      lambda { |race| "[ #{race} / Pendulum / Tuner / Effect ]" },
    'Pendulum Effect Fusion Monster' =>
      lambda { |race| "[ #{race} / Pendulum / Effect / Fusion ]" },
    'Link Monster' => lambda { |race| "[ #{race} / Link / Effect ]" }
  }.freeze

  def self.message(from)
    atem = Ygoprodeck::Fname.is(from)

    # Check if atem is nil before trying to access its elements
    return "*#{from}* not found" if atem.nil? || atem['id'].nil?

    id = atem['id']
    name = atem['name']
    type = atem['type']
    desc = atem['desc']

    if MONSTER_TYPES.include?(type)
      format_monster_card(atem, type)
    elsif NON_MONSTER_TYPES.include?(type)
      format_non_monster_card(atem)
    else
      # Handle unknown card types
      "*#{name}* has unrecognized type: #{type}"
    end
  end

  private

  def self.format_monster_card(card, type)
    name = card['name']
    type = card['type']
    attribute = card['attribute']
    level = card['level']
    race = card['race']
    desc = card['desc']
    m_atk = card['atk']
    m_def = card['def']

    about = TYPE_DESCRIPTIONS[type]&.call(race) || ''

    "*#Name*:\n#{name}\n*#Type:*\n#{type}\n*#Attribute*:\n#{attribute}\n*#Level*:\n#{level}\n*#Desc:*\n*#{about}*\n#{desc}\n*#Atk/#Def:*\n#{m_atk}/#{m_def}"
  end

  def self.format_non_monster_card(card)
    name = card['name']
    type = card['type']
    race = card['race']
    desc = card['desc']

    "*#Name*:\n#{name}\n*#Type:*\n#{type}\n*#Property*:\n#{race}\n*#Effect*\n#{desc}"
  end
end
