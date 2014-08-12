require 'bound'

module Tarot
  module UseCases
    class DealForSpread< UseCase

      Card = Services::CardBoundary::Card

      Input = Bound.required(
        :used_spread
      ).optional(
        :cards
      )

      Result = Bound.required(
        :count,
        :average,
        :cards => [Card]
      )

      def initialize(input)
        input = Input.new(input)
        @used_spread  = return_used_spread_or_raise_error!(input.used_spread)
        @preset_cards = input.cards || []
        @card_counter = card_counter
      end

      def call
        Result.new(
          :cards    => build_cards,
          :count    => count_for_cards,
          :average  => avg_for_cards
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
        number_of_cards = get_number_of_cards_to_deal

        return deal_preset_cards(number_of_cards) if cards_specified?
        Entities::Deck.new.deal(number_of_cards)
      end

      def deal_preset_cards(number_of_cards)
        Entities::Deck.new(preset_cards).deal(number_of_cards)
      end

      def get_count_for_cards
        card_counter.count
      end

      def get_avg_for_cards
        card_counter.average
      end

      def get_number_of_cards_to_deal
        return nil if used_spread == :all
        SPREADS[used_spread]
      end

      def return_used_spread_or_raise_error!(spread)
        ensure_available_spread!(spread)

        spread
      end

      def ensure_available_spread!(spread)
        available_spreads = SPREADS.keys + [:all]

        unless available_spreads.include?(spread)
          reason = "#{spread} is not an available spread"
          raise_argument_error(reason, spread)
        end
      end

      def cards_specified?
        @preset_cards.any?
      end

      def preset_cards
        @preset_cards
      end

      def used_spread
        @used_spread
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