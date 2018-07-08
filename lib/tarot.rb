Dir[File.join(__dir__, 'tarot', '*.rb')].each {|f| require f }

module Tarot
  DEFAULT_DECK = :marseille # What deck is used when none is specified?
  AVAILABLE_DECKS = [:marseille, :rider_waite_smith]
end
