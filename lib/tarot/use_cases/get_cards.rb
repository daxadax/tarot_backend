require 'bound'

module Tarot
  module UseCases
    class GetCards < UseCase
      Card = Services::CardBoundary::Card
      Input = Bound.optional(
        :quantity,
        :cards,
        :time_of_reading
      )

      Result = Bound.required(
        :count,
        :average,
        :cards => [Card]
      )

      def initialize(input)
        input = Input.new(input)
        @quantity = input.quantity || 78
        @preset_cards = input.cards || []
      end

      def call
        Result.new(
          :cards => build_cards,
          :count => count_for_cards,
          :average => avg_for_cards
        )
      end

      private

      def build_cards
        cards_for_spread.map do |card|
          card_boundary.for(card)
        end
      end

      def cards_for_spread
        @cards ||= get_cards_for_spread
      end

      def count_for_cards
        @count_for_cards ||= get_count_for_cards
      end

      def avg_for_cards
        @avg_for_cards ||= get_avg_for_cards
      end

      def get_cards_for_spread
         if cards_specified?
           card_factory.get_multiple preset_cards
        else
          cards = card_factory.all.shuffle
          cards.first(quantity)
        end
      end

      def get_count_for_cards
        card_counter.count
      end

      def get_avg_for_cards
        card_counter.average
      end

      def cards_specified?
        @preset_cards.any?
      end

      def preset_cards
        @preset_cards
      end

      def quantity
        @quantity
      end

      def card_counter
        @card_counter ||= Services::CardCounter.new(cards_for_spread)
      end

      def card_boundary
        Services::CardBoundary.new
      end
    end
  end
end
