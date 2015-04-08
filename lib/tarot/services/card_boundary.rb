require 'bound'

module Tarot
  module Services
    class CardBoundary < Service
      
      Associations = Bound.required(
        :general,
        :golden_dawn
      )

      Card = Bound.required(
        :id,
        :arcana,
        :display_name,
        :element,
        :domain,
        :suit,
        :is_minor,
        :is_major,
        :is_reversed,
        :is_court_card,
        :associations => Associations
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
          :element => determine_element(card),
          :domain => determine_domain(card),
          :suit => determine_suit(card),
          :is_minor => card.minor?,
          :is_major => card.major?,
          :is_reversed => card.reversed?,
          :is_court_card => card.court?,
          :associations => build_associations(card.associations),
        )
      end

      def build_associations(associations)
        Associations.new(
          :general => associations.general,
          :golden_dawn => associations.golden_dawn
        )
      end

      def determine_element(card)
        return card.suit.element if card.minor?
        card.element
      end

      def determine_domain(card)
        return card.suit.domain if card.minor?
        card.domain
      end

      def determine_suit(card)
        return 'Trumps' if card.major?
        card.suit.name
      end

    end
  end
end
