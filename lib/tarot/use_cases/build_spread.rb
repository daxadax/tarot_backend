module Tarot
  module UseCases
    class BuildSpread < UseCase

      class Result < Struct.new(:cards, :count, :average);end

      def initialize(spread)
        @used_spread  = return_used_spread_or_raise_error!(spread)
        @card_counter = card_counter
      end

      def call
        Result.new( cards_for_spread, count_for_cards, avg_for_cards )
      end

      private

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
        number_of_cards = LAYOUTS[used_spread]

        Entities::Deck.new.deal(number_of_cards)
      end

      def get_count_for_cards
        card_counter.count
      end

      def get_avg_for_cards
        card_counter.average
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

      def card_counter
        @card_counter ||= Services::CardCounter.new(cards_for_spread)
      end

    end
  end
end