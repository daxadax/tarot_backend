module Tarot
  module UseCases
    class BuildSpread < UseCase

      def initialize(spread)
        @used_spread = return_used_spread_or_raise_error!(spread)
      end

      def call
        get_cards_for_spread
      end

      private

      def return_used_spread_or_raise_error!(spread)
        ensure_available_spread!(spread)

        spread
      end

      def get_cards_for_spread
        number_of_cards = LAYOUTS[used_spread]

        Entities::Deck.new.deal(number_of_cards)
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