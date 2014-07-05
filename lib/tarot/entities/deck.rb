module Tarot
  module Entities
    class Deck < Entity
      attr_reader :name

      def initialize
        @cards  = []
      end

      def deal(number_of_cards = nil)
        build_new_deck

        return cards.shuffle.pop(number_of_cards) if number_of_cards
        cards
      end

      private

      def build_new_deck
        cards.clear
        build_minor_arcana
        build_major_arcana
        cards.flatten
      end

      def build_minor_arcana
        suits.each do |suit|
          MINOR_ARCANA.keys.each do |rank|
            cards << Entities::MinorArcana.new("#{suit}_#{rank}")
          end
        end
      end

      def build_major_arcana
        MAJOR_ARCANA.keys.each do |id|
          cards << Entities::MajorArcana.new(id)
        end
      end

      def cards
        @cards
      end

      def suits
        %w[w p c s]
      end

    end
  end
end
