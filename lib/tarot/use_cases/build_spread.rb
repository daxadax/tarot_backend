module Tarot
  module UseCases
    class BuildSpread < UseCase

      class Result < Struct.new(:cards, :stats);end

      def initialize(spread)
        @used_spread = return_used_spread_or_raise_error!(spread)
      end

      def call
        Result.new( cards_for_spread, get_stats_for_cards )
      end

      private

      def cards_for_spread
        @cards ||= get_cards_for_spread
      end

      def get_stats_for_cards
        Services::CardCounter.new(cards_for_spread).count
      end

      def get_cards_for_spread
        number_of_cards = LAYOUTS[used_spread]

        Entities::Deck.new.deal(number_of_cards)
      end

      def return_used_spread_or_raise_error!(spread)
        ensure_available_spread!(spread)

        spread
      end

      def ensure_available_spread!(spread)
        unless LAYOUTS.keys.include?(spread)
          reason = "#{spread} is not an available spread"
          raise_argument_error(reason, spread)
        end
      end

      def used_spread
        @used_spread
      end

    end
  end
end