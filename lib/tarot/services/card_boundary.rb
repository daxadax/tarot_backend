require 'bound'

module Tarot
  module Services
    class CardBoundary < Service
      Card = Bound.required(
        :id,
        :arcana,
        :display_name,
        :element,
        :suit,
        :astrological_signs,
        :correspondence,
        :elemental_correspondence,
        :golden_dawn_correspondence,
        :is_minor,
        :is_major,
        :is_court_card,
      )

      def for(card)
        build_boundary(card)
      end

      private

      def build_boundary(card)
        Card.new(
          :id => card.id,
          :arcana => card.arcana,
          :display_name => card.display_name,
          :element => card.element,
          :suit => card.suit,
          :astrological_signs => card.astrological_signs,
          :correspondence => card.correspondence.general,
          :elemental_correspondence => card.correspondence.elemental,
          :golden_dawn_correspondence => card.correspondence.golden_dawn,
          :is_minor => card.minor?,
          :is_major => card.major?,
          :is_court_card => card.court?,
        )
      end
    end
  end
end
