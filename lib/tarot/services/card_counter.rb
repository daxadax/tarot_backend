require 'ostruct'

module Tarot
  module Services
    class CardCounter < Service

      def initialize(cards)
        @cards = cards
      end

      def count
        OpenStruct.new(
          :major        => count_cards(:major),
          :wands        => count_cards(:wands),
          :pentacles    => count_cards(:pentacles),
          :cups         => count_cards(:cups),
          :swords       => count_cards(:swords),
          :court_cards  => count_cards(:court),
          :reversed     => count_cards(:reversed)
        )
      end

      private

      def count_cards(type)
        get_cards(type).count
      end

      def get_cards(type)
        case type
        when :major
          select_major_cards
        when :reversed
          select_reversed_cards
        when :court
          select_court_cards
        else
          select_minor_cards(type)
        end
      end

      def select_major_cards
        cards.select { |card| card.major? }
      end

      def select_reversed_cards
        cards.select { |card| card.reversed? }
      end

      def select_court_cards
        cards.select { |card| card.court? }
      end

      def select_minor_cards(type)
        cards.select do |card|
          card.minor? && card.suit.name =~ /#{type}/i
        end
      end

      def cards
        @cards
      end

    end
  end
end