require 'tarot/version'

require_relative 'tarot/support/validation_helpers'

require_relative 'tarot/entities'
require_relative 'tarot/services'
require_relative 'tarot/use_cases'

module Tarot
  SuitAttributes    = Struct.new(:element, :domain)
  MinorAttributes   = Struct.new(:title, :associations)
  MajorAttributes   = Struct.new(:title, :element, :domain, :associations)


  LAYOUTS           = {
    :three_card => 3,
    :enneagram  => 9
  }

  SUITS = {
    :wands      => SuitAttributes.new(:fire,   ['masculine', 'instinctual']),
    :pentacles  => SuitAttributes.new(:earth,  ['practical', 'logistical']),
    :cups       => SuitAttributes.new(:water,  ['feminine', 'emotional', 'cultural', 'social']),
    :swords     => SuitAttributes.new(:air,    ['intellectual'])
  }

  MINOR_ARCANA      = {
    '01' => MinorAttributes.new(
      :ace, ['birth', 'creation', 'a gift', 'a surprise']
    ),
    '02' => MinorAttributes.new(
      :two, ['balance', 'unity', 'duality', 'conflict', 'tension']
    ),
    '03' => MinorAttributes.new(
      :three, []
    ),
    '04' => MinorAttributes.new(
      :four, []
    ),
    '05' => MinorAttributes.new(
      :five, []
    ),
    '06' => MinorAttributes.new(
      :six, []
    ),
    '07' => MinorAttributes.new(
      :seven, []
    ),
    '08' => MinorAttributes.new(
      :eight, []
    ),
    '09' => MinorAttributes.new(
      :nine, []
    ),
    '10' => MinorAttributes.new(
      :ten, []
    ),
    '11' => MinorAttributes.new(
      :prince, ['routine', 'movement', 'training']
    ),
    '12' => MinorAttributes.new(
      :knight, ['instinctual', 'sub-conscious desire', 'behind-the-scenes', 'drive']
    ),
    '13' => MinorAttributes.new(
      :queen, ['drawn attention', 'ambition', 'desire', 'deriving pleasure from']
    ),
    '14' => MinorAttributes.new(
      :king, ['concentrated attention', 'synthesis', 'supervision' ]
    )
  }

  MAJOR_ARCANA      = {
    '00' => MajorAttributes.new(
      'The Fool', :air, [], [] ),
    '01' => MajorAttributes.new(
      'The Magician', :air, [], [] ),
    '02' => MajorAttributes.new(
      'The High Priestess', :water, [], [] ),
    '03' => MajorAttributes.new(
      'The Empress', :earth, [], [] ),
    '04' => MajorAttributes.new(
      'The Emperor', :fire, [], [] ),
    '05' => MajorAttributes.new(
      'The Hierophant', :earth, [], [] ),
    '06' => MajorAttributes.new(
      'The Lovers', :air, [], [] ),
    '07' => MajorAttributes.new(
      'The Chariot', :water, [], [] ),
    '08' => MajorAttributes.new(
      'Strength', :fire, [], [] ),
    '09' => MajorAttributes.new(
      'The Hermit', :earth, [], [] ),
    '10' => MajorAttributes.new(
      'The Wheel', :fire, [], [] ),
    '11' => MajorAttributes.new(
      'Justice', :air, [], [] ),
    '12' => MajorAttributes.new(
      'The Hanged Man', :water, [], [] ),
    '13' => MajorAttributes.new(
      'Death', :water, [], [] ),
    '14' => MajorAttributes.new(
      'Temperance', :fire, [], [] ),
    '15' => MajorAttributes.new(
      'The Devil', :earth, [], [] ),
    '16' => MajorAttributes.new(
      'The Tower', :fire, [], [] ),
    '17' => MajorAttributes.new(
      'The Star', :air, [], [] ),
    '18' => MajorAttributes.new(
      'The Moon', :water, [], [] ),
    '19' => MajorAttributes.new(
      'The Sun', :fire, [], [] ),
    '20' => MajorAttributes.new(
      'Judgement', :fire, [], [] ),
    '21' => MajorAttributes.new(
      'The World', :earth, [], [] )
  }

end
