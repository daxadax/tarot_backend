module Tarot
  module Entities
    class Deck

      def initialize
        @deck = []
      end

      def deal(number = 9)
        build_new_deck

        deck.shuffle.pop(number)
      end

      private

      def build_new_deck
        deck.clear
        build_minor_arcana
        build_major_arcana
        deck.flatten
      end

      def build_minor_arcana
        suits.each do |suit|
          minor_arcana.each do |rank|
            deck << Entities::MinorArcana.new("#{suit}_#{rank}")
          end
        end
      end

      def build_major_arcana
        major_arcana.each do |id|
          deck << Entities::MajorArcana.new(id)
        end
      end

      def deck
        @deck
      end

      def suits
        %w[w p c s]
      end

      def minor_arcana
        (1..14).to_a
      end

      def major_arcana
        (0..21).to_a
      end

    end
  end
end
