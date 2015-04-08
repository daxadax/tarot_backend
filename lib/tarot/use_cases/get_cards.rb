require 'bound'

module Tarot
  module UseCases
    class GetCards < UseCase

      Card = Services::CardBoundary::Card
      Moon = Bound.required(
        :age,
        :illumination,
        :phase,
        :is_waxing,
        :is_waning
      )

      Input = Bound.optional(
        :quantity,
        :cards,
        :time_of_reading
      )

      Result = Bound.required(
        :count,
        :average,
        :cards => [Card],
        :moon => Moon
      )

      def initialize(input)
        input = Input.new(input)
        @quantity = input.quantity
        @preset_cards = input.cards || []
        @moon = fetch_lunar_data(input.time_of_reading)
      end

      def call
        Result.new(
          :cards => build_cards,
          :moon => build_moon,
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

      def build_moon
        Moon.new(
          :age => moon.age,
          :illumination => moon.illumination,
          :phase => moon.phase,
          :is_waxing => moon.waxing?,
          :is_waning => moon.waning?
        )
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
        return Entities::Deck.new(preset_cards).deal if cards_specified?
        Entities::Deck.new.deal(quantity)
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

      def moon
        @moon
      end

      def card_counter
        @card_counter ||= Services::CardCounter.new(cards_for_spread)
      end

      def fetch_lunar_data(time)
        Services::MoonInfo.new(time)
      end

      def card_boundary
        Services::CardBoundary.new
      end

    end
  end
end
