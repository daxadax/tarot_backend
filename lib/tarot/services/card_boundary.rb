require 'bound'

module Tarot
  module Services
    class CardBoundary < Service

      Card = Bound.required(
        :id,
        :arcana,
        :display_name,
        :element,
        :domain,
        :associations,
        :suit,
        :is_minor,
        :is_major,
        :is_reversed,
        :is_court_card
      )

      def for(card)
        build_boundary(card)
      end

      private

      def build_boundary(card)
        Card.new(
          :id             => card.id,
          :arcana         => card.arcana,
          :display_name   => card.display_name,
          :element        => determine_element(card),
          :domain         => determine_domain(card),
          :associations   => card.associations,
          :suit           => determine_suit(card),
          :is_minor       => card.minor?,
          :is_major       => card.major?,
          :is_reversed    => card.reversed?,
          :is_court_card  => card.court?
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
        return 'Trump' if card.major?
        card.suit.name
      end

    end
  end
end