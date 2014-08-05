require 'ostruct'

module Tarot
  module Services
    class CardCounter < Service

      def initialize(cards)
        @cards      = cards
        @card_stats = Hash.new
      end

      def count
        OpenStruct.new(
          :major        => count_for(:major),
          :wands        => count_for(:wands),
          :pentacles    => count_for(:pentacles),
          :cups         => count_for(:cups),
          :swords       => count_for(:swords),
          :court_cards  => count_for(:court),
          :reversed     => count_for(:reversed)
        )
      end

      def average
        OpenStruct.new(
          :major        => average_for(:major),
          :wands        => average_for(:wands),
          :pentacles    => average_for(:pentacles),
          :cups         => average_for(:cups),
          :swords       => average_for(:swords),
          :court_cards  => average_for(:court),
          :reversed     => average_for(:reversed)
        )
      end

      def average_over_threshold(threshold)
        card_averages = [
          :major, :wands, :pentacles, :cups, :swords, :court, :reversed
        ].map { |type| average_for type }

        return true if card_averages.any? { |avg| avg > threshold}
        false
      end

      private

      def count_for(type)
        card_stats(type).count
      end

      def average_for(type)
        (count_for(type)/cards.count.to_f * 100).round
      end

      def get_cards(type)
        case type
        when :major
          select_cards(:major?)
        when :reversed
          select_cards(:reversed?)
        when :court
          select_cards(:court?)
        else
          select_minor_cards(type)
        end
      end

      def select_cards(type)
        cards.select { |card| card.public_send type }
      end

      def select_minor_cards(type)
        cards.select do |card|
          card.minor? && card.suit.name =~ /#{type}/i
        end
      end

      def card_stats(type)
        @card_stats.fetch(type) { get_cards(type) }
      end

      def cards
        @cards
      end

    end
  end
end