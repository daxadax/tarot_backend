Dir.glob("./lib/tarot/*.rb") { |f| require f }

module Tarot
  DEFAULT_DECK = :marseille # What deck is used when none is specified?
  AVAILABLE_DECKS = [:marseille, :rider_waite_smith]
end
