require "tarot/version"

require_relative "tarot/support/validation_helpers"

require_relative "tarot/entities"
require_relative "tarot/use_cases"

module Tarot
  class CardAttributes < Struct.new(:title, :associations); end
  class SuitAttributes < Struct.new(:element, :associations); end

  LAYOUTS           = {
    :enneagram => 9
  }

  SUITS = {
    :wands      => SuitAttributes.new(:fire,   ['yang', 'instinctual']),
    :pentacles  => SuitAttributes.new(:earth,  ['practical', 'logistical']),
    :cups       => SuitAttributes.new(:water,  ['yin', 'emotional', 'cultural', 'social']),
    :swords     => SuitAttributes.new(:air,    ['intellectual'])
  }

  MAJOR_ARCANA      = {
    '00' => CardAttributes.new( 'The Fool',            [] ),
    '01' => CardAttributes.new( 'The Magician',        [] ),
    '02' => CardAttributes.new( 'The High Priestess',  [] ),
    '03' => CardAttributes.new( 'The Empress',         [] ),
    '04' => CardAttributes.new( 'The Emperor',         [] ),
    '05' => CardAttributes.new( 'The Hierophant',      [] ),
    '06' => CardAttributes.new( 'The Lovers',          [] ),
    '07' => CardAttributes.new( 'The Chariot',         [] ),
    '08' => CardAttributes.new( 'Strength',            [] ),
    '09' => CardAttributes.new( 'The Hermit',          [] ),
    '10' => CardAttributes.new( 'The Wheel',           [] ),
    '11' => CardAttributes.new( 'Justice',             [] ),
    '12' => CardAttributes.new( 'The Hanged Man',      [] ),
    '13' => CardAttributes.new( 'Death',               [] ),
    '14' => CardAttributes.new( 'Temperance',          [] ),
    '15' => CardAttributes.new( 'The Devil',           [] ),
    '16' => CardAttributes.new( 'The Tower',           [] ),
    '17' => CardAttributes.new( 'The Star',            [] ),
    '18' => CardAttributes.new( 'The Moon',            [] ),
    '19' => CardAttributes.new( 'The Sun',             [] ),
    '20' => CardAttributes.new( 'Judgement',           [] ),
    '21' => CardAttributes.new( 'The World',           [] )
  }

  MINOR_ARCANA      = {
    '01' => CardAttributes.new( :ace,     ['birth', 'creation', 'a gift', 'a surprise'] ),
    '02' => CardAttributes.new( :two,     ['balance', 'unity', 'duality', 'conflict', 'tension'] ),
    '03' => CardAttributes.new( :three,   [] ),
    '04' => CardAttributes.new( :four,    [] ),
    '05' => CardAttributes.new( :five,    [] ),
    '06' => CardAttributes.new( :six,     [] ),
    '07' => CardAttributes.new( :seven,   [] ),
    '08' => CardAttributes.new( :eight,   [] ),
    '09' => CardAttributes.new( :nine,    [] ),
    '10' => CardAttributes.new( :ten,     [] ),
    '11' => CardAttributes.new( :prince,  ['routine', 'movement', 'training'] ),
    '12' => CardAttributes.new( :knight,  ['instinctual', 'sub-conscious desire', 'behind-the-scenes', 'drive'] ),
    '13' => CardAttributes.new( :queen,   ['drawn attention', 'ambition', 'desire', 'deriving pleasure from'] ),
    '14' => CardAttributes.new( :king,    ['concentrated attention', 'synthesis', 'supervision' ] ),
  }

end
