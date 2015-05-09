require 'bound'

module Tarot
  module Services
    class CardBoundary < Service
      Correspondence = Bound.required(
        :golden_dawn
      )

      Card = Bound.required(
        :id,
        :arcana,
        :display_name,
        :elements,
        :suit,
        :astrological_signs,
        :is_minor,
        :is_major,
        :is_court_card,
        :correspondence => Correspondence
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
          :elements => card.elements,
          :suit => card.suit,
          :astrological_signs => card.astrological_signs,
          :is_minor => card.minor?,
          :is_major => card.major?,
          :is_court_card => card.court?,
          :correspondence => Correspondence.new(
            :golden_dawn => card.correspondence.golden_dawn,
          )
        )
      end
    end
  end
end
