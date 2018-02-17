require 'bound'

module Tarot
  module Services
    class CardBoundary < Service
      Correspondence = Bound.optional(
        :marseille,
        :rider_waite_smith
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
          id: card.id,
          arcana: card.arcana.to_sym,
          display_name: card.display_name,
          elements: card.elements.map(&:to_sym),
          suit: card.suit.to_sym,
          astrological_signs: card.astrological_signs.map(&:to_sym),
          is_minor: card.minor?,
          is_major: card.major?,
          is_court_card: card.court?,
          correspondence: Correspondence.new(
            marseille: card.correspondence.marseille,
            rider_waite_smith: card.correspondence.rider_waite_smith
          )
        )
      end
    end
  end
end
