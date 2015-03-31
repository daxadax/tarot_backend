require 'tarot/version'

require_relative 'tarot/support/validation_helpers'

require_relative 'tarot/entities'
require_relative 'tarot/services'
require_relative 'tarot/use_cases'

module Tarot
  SuitAttributes = Struct.new(:element, :domain)
  MinorAttributes = Struct.new(:title, :associations)
  MajorAttributes = Struct.new(:title, :element, :domain, :associations)

  domain_for_fire_elements  = ['masculine', 'instinctual']
  domain_for_earth_elements = ['practical', 'logistical', 'financial', 'transportation']
  domain_for_water_elements = ['feminine', 'emotional', 'cultural', 'social']
  domain_for_air_elements   = ['thought patterns', 'education and learning', 'communication']

  SUITS = {
    :wands => SuitAttributes.new(:fire,  domain_for_fire_elements),
    :pentacles => SuitAttributes.new(:earth, domain_for_earth_elements),
    :cups => SuitAttributes.new(:water, domain_for_water_elements),
    :swords => SuitAttributes.new(:air,   domain_for_air_elements)
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
      ['finality', 'the end of a cycle']
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
    '00' => MajorAttributes.new( 'The Fool',
      :air, domain_for_air_elements,
      [
        'new beginnings', 'spontanaeity', 'ignorance', 'amor fati', 'unorthadox', 'forgotten power',
        'breath of life', 'spirit'
      ]
    ),
    '01' => MajorAttributes.new( 'The Magician',
      :air, domain_for_air_elements,
      ['conscious action', 'acting with will', 'concentrated attention', 'creativity', 'life and death']
    ),
    '02' => MajorAttributes.new( 'The High Priestess',
      :water, domain_for_water_elements,
      [
        'patience', 'discernment', 'balance', 'guidance', 'passive action', 'sub-conscious',
        'memory', 'peace and strife'
      ]
    ),
    '03' => MajorAttributes.new( 'The Empress',
      :earth, domain_for_earth_elements,
      ['point of no return', 'decisiveness', 'imagination', 'wisdom and folly']
    ),
    '04' => MajorAttributes.new( 'The Emperor',
      :fire, domain_for_fire_elements,
      ['stability', 'reason', 'sense of sight']
    ),
    '05' => MajorAttributes.new( 'The Hierophant',
      :earth, domain_for_earth_elements,
      [
        'academia', 'heritage', 'discipline', 'doing what is expected', 'the Establishment',
        'commitment to a cause', 'dominance/submission', 'roles', 'intuition', 'sense of hearing'
      ]
    ),
    '06' => MajorAttributes.new( 'The Lovers',
      :air, domain_for_air_elements,
      [
        'awareness', 'harmony', 'forming a union', 'physical attraction', 'making a connection',
        'determining what you really care about', 'roles', 'discrimination', 'sense of smell'
      ]
    ),
    '07' => MajorAttributes.new( 'The Chariot',
      :water, domain_for_water_elements,
      ['inner conviction', 'acting alone', 'receptive will', 'speech']
    ),
    '08' => MajorAttributes.new( 'Strength',
      :fire, domain_for_fire_elements,
      ['recurrence', 'determination', 'purpose', 'suggestion', 'digestion']
    ),
    '09' => MajorAttributes.new( 'The Hermit',
      :earth, domain_for_earth_elements,
      [
        'instrospection', 'anticipation/anxiety', 'contemplation', 'end of a cycle',
        'offering or seeking guidance', 'quitting old habits', 'withdraw from worldly affairs',
        'acting alone', 'union of opposites', 'sense of touch'
      ]
    ),
    '10' => MajorAttributes.new( 'The Wheel',
      :fire, domain_for_fire_elements,
      ['change', 'transition', 'finality','the end of a cycle', 'new beginnings', 'wealth and poverty']
    ),
    '11' => MajorAttributes.new( 'Justice',
      :air, domain_for_air_elements,
      ['awareness', 'equilibrium', 'action-work']
    ),
    '12' => MajorAttributes.new( 'The Hanged Man',
      :water, domain_for_water_elements,
      ['patience', 'passivity', 'reversal', 'equanimity']
    ),
    '13' => MajorAttributes.new( 'Death',
      :water, domain_for_water_elements,
      ['point of no return', 'decisiveness', 'transformation', 'motion']
    ),
    '14' => MajorAttributes.new( 'Temperance',
      :fire, domain_for_fire_elements,
      ['stability', 'verification', 'wrath']
    ),
    '15' => MajorAttributes.new( 'The Devil',
      :earth, domain_for_earth_elements,
      ['dominance/submission', 'uncontrolled energy', 'change', 'bondage', 'mirth']
    ),
    '16' => MajorAttributes.new( 'The Tower',
      :fire, domain_for_fire_elements,
      ['awareness', 'departure', 'awakening', 'sin and grace']
    ),
    '17' => MajorAttributes.new( 'The Star',
      :air, domain_for_air_elements,
      ['acting alone', 'revelation', 'meditation']
    ),
    '18' => MajorAttributes.new( 'The Moon',
      :water, domain_for_water_elements,
      ['cycles', 'recurrence', 'focus', 'organization', 'sleep']
    ),
    '19' => MajorAttributes.new( 'The Sun',
      :fire, domain_for_fire_elements,
      ['acting alone', 'awareness', 'nearing completion', 'regeneration', 'fertility and sterility']
    ),
    '20' => MajorAttributes.new( 'Judgement',
      :fire, domain_for_fire_elements,
      ['communication', 'cycles', 'realization', 'decision']
    ),
    '21' => MajorAttributes.new( 'The World',
      :earth, domain_for_earth_elements,
      ['appearances', 'essence', 'roles', 'universal consciousness', 'dominion and slavery']
    )
  }

end
