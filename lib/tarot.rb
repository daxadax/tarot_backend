require "tarot/version"

# require all support files
require_relative "tarot/support/validation_helpers"

require_relative "tarot/entities"
require_relative "tarot/use_cases"

module Tarot

  LAYOUTS           = {
    :enneagram => 9
  }

  SUIT_ASSOCIATIONS = {
    :wand     => %w[instinctual],
    :pentacle => %w[practical logistical],
    :cup      => %w[emotional cultural social],
    :sword    => %w[intellectual]
  }

  MAJOR_ARCANA      = {
    '00' => 'The Fool',
    '01' => 'The Magician',
    '02' => 'The High Priestess',
    '03' => 'The Empress',
    '04' => 'The Emperor',
    '05' => 'The Hierophant',
    '06' => 'The Lovers',
    '07' => 'The Chariot',
    '08' => 'Strength',
    '09' => 'The Hermit',
    '10' => 'The Wheel',
    '11' => 'Justice',
    '12' => 'The Hanged Man',
    '13' => 'Death',
    '14' => 'Temperance',
    '15' => 'The Devil',
    '16' => 'The Tower',
    '17' => 'The Star',
    '18' => 'The Moon',
    '19' => 'The Sun',
    '20' => 'Judgement',
    '21' => 'The World'
  }

  MINOR_ARCANA      = {
    '01' => :ace,
    '02' => :two,
    '03' => :three,
    '04' => :four,
    '05' => :five,
    '06' => :six,
    '07' => :seven,
    '08' => :eight,
    '09' => :nine,
    '10' => :ten,
    '11' => :knight,
    '12' => :prince,
    '13' => :queen,
    '14' => :king
  }

end
