require 'ostruct'

module Tarot
  module Services
    class CardCounter < Service

      def initialize(cards)
        @cards = cards
      end

      def count
        cards.each_with_index.inject({}) do |result, (card, index)|
          previous_result = index.zero? ? [] : count_hash(result[index - 1])
          result[index] = count_symbols(card, previous_result)
          result
        end
      end

      private

      def count_symbols(card, previous_result)
        symbols = fetch_symbols(card, previous_result)

        symbols.inject(Hash.new(0)) do |result, symbol|
          result[symbol] += 1
          result
        end
      end

      def fetch_symbols(card, previous)
        previous + [
          card.elements,
          card.astrological_signs
        ].flatten.map(&:to_sym)
      end

      def count_hash(hash)
        hash.flat_map do |symbol, count|
          [symbol] * count
        end
      end

      def cards
        @cards
      end
    end
  end
end
