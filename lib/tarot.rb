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
    :pentacles  => SuitAttributes.new(:earth,  ['practical', 'logistical', 'financial', 'transportation']),
    :cups       => SuitAttributes.new(:water,  ['feminine', 'emotional', 'cultural', 'social']),
    :swords     => SuitAttributes.new(:air,    ['thought patterns', 'education and learning', 'communication'])
  }

  MINOR_ARCANA      = {
    '01' => MinorAttributes.new( :ace,
      ['birth', 'creation', 'a gift', 'a surprise', 'solitude']
    ),
    '02' => MinorAttributes.new( :two,
      ['balance', 'unity', 'duality', 'conflict', 'tension', 'patience', 'relationship', 'instability']
    ),
    '03' => MinorAttributes.new( :three,
      ['social interaction', 'groups', 'decisiveness', 'resolve', 'point of no return']
    ),
    '04' => MinorAttributes.new( :four,
      ['re-evaluation', 'contemplation', 'time to rest and reflect', 'crossroads', 'stability']
    ),
    '05' => MinorAttributes.new( :five,
      ['change', 'loss', 'hard times', 'confusion', 'discord', 'dissonance', 'balance of power', 'dominance/submission']
    ),
    '06' => MinorAttributes.new( :six,
      ['consequences of past action', 'new beginnings', 'departure', 'balance', 'harmony', 'awareness']
    ),
    '07' => MinorAttributes.new( :seven,
      ['solitude', 'acting alone', 'inner conviction']
    ),
    '08' => MinorAttributes.new( :eight,
      ['recurrence', 'cycles', 'determination', 'focus', 'purpose']
    ),
    '09' => MinorAttributes.new( :nine,
      ['solitude', 'isolation', 'anticipation/anxiety', 'nearing completion']
    ),
    '10' => MinorAttributes.new( :ten,
      []
    ),
    '11' => MinorAttributes.new( :prince,
      ['instinctual desire', 'sub-conscious', 'behind-the-scenes', 'drive']
    ),
    '12' => MinorAttributes.new( :knight,
      ['physical desire', 'routine', 'movement', 'training']
    ),
    '13' => MinorAttributes.new( :queen,
      ['emotional desire', 'drawn attention', 'ambition', 'desire', 'pleasure']
    ),
    '14' => MinorAttributes.new( :king,
      ['intellectual desire', 'concentrated attention', 'synthesis', 'supervision', 'consciousness']
    )
  }

  MAJOR_ARCANA      = {
    '00' => MajorAttributes.new( 'The Fool', :air,
      ['cultural', 'social', 'instinctual'],
      ['new beginnings', 'spontanaeity', 'joyful innocence', 'amor fati', 'unorthadox']
    ),
    '01' => MajorAttributes.new( 'The Magician', :air,
      ['masculine', 'active', 'creative'],
      ['conscious action', 'acting with will', 'concentrated attention']
    ),
    '02' => MajorAttributes.new( 'The High Priestess', :water,
      ['passive', 'feminine'],
      ['patience', 'discernment', 'balance']
    ),
    '03' => MajorAttributes.new( 'The Empress', :earth,
      [],
      ['point of no return', 'decisiveness']
    ),
    '04' => MajorAttributes.new( 'The Emperor', :fire,
      [],
      ['stability']
    ),
    '05' => MajorAttributes.new( 'The Hierophant', :earth,
      ['roles and relationship', 'cultural', 'social', 'academic'],
      ['education systems', 'heritage', 'discipline', 'doing what is expected', 'the Establishment', 'commitment to a cause', 'dominance/submission']
    ),
    '06' => MajorAttributes.new( 'The Lovers', :air,
      ['roles and relationship', 'intellectual', 'physical'],
      ['awareness', 'harmony', 'forming a union', 'physical attraction', 'making a connection', 'determining what you really care about']
    ),
    '07' => MajorAttributes.new( 'The Chariot', :water,
      ['acting alone'],
      ['inner conviction']
    ),
    '08' => MajorAttributes.new( 'Strength', :fire,
      [],
      ['recurrence', 'determination', 'purpose']
    ),
    '09' => MajorAttributes.new( 'The Hermit', :earth,
      ['society', 'intellectual', 'emotional', 'acting alone'],
      ['instrospection', 'anticipation/anxiety', 'contemplation', 'end of a cycle', 'offering or seeking guidance', 'quitting old habits', 'withdraw from worldly affairs' ]
    ),
    '10' => MajorAttributes.new( 'The Wheel', :fire,
      [],
      []
    ),
    '11' => MajorAttributes.new( 'Justice', :air,
      [],
      []
    ),
    '12' => MajorAttributes.new( 'The Hanged Man', :water,
      [],
      ['patience']
    ),
    '13' => MajorAttributes.new( 'Death', :water,
      [],
      ['point of no return', 'decisiveness']
    ),
    '14' => MajorAttributes.new( 'Temperance', :fire,
      [],
      ['stability']
    ),
    '15' => MajorAttributes.new( 'The Devil', :earth,
      [],
      ['dominance/submission', 'uncontrolled energy', 'change']
    ),
    '16' => MajorAttributes.new( 'The Tower', :fire,
      [],
      ['awareness', 'departure', ]
    ),
    '17' => MajorAttributes.new( 'The Star', :air,
      ['acting alone'],
      []
    ),
    '18' => MajorAttributes.new( 'The Moon', :water,
      ['cycles'],
      ['recurrence', 'focus']
    ),
    '19' => MajorAttributes.new( 'The Sun', :fire,
      ['acting alone'],
      ['awareness', 'nearing completion']
    ),
    '20' => MajorAttributes.new( 'Judgement', :fire,
      [],
      []
    ),
    '21' => MajorAttributes.new( 'The World', :earth,
      [],
      []
    )
  }

end
