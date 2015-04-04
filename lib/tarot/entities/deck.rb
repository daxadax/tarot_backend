module Tarot
  module Entities
    class Deck < Entity
      attr_reader :name

      def initialize(cards = nil)
        @cards = set_value_of cards
      end

      def deal(number_of_cards = nil)
        build_new_deck if cards.empty?

        return cards.shuffle.pop(number_of_cards) if number_of_cards
        cards
      end

      private

      def build_deck_from(cards)
        cards.map { |id| build_card(id) }
      end

      def build_new_deck
        cards.clear
        build_all_minor_arcana
        build_all_major_arcana
        cards.flatten
      end

      def build_all_minor_arcana
        Entities::MinorArcana.build_all.each do |card|
          cards << card
        end
      end

      def build_all_major_arcana
        Entities::MajorArcana.build_all.each do |card|
          cards << card
        end
      end

      def build_card(id)
        return Entities::MinorArcana.new(id) if id.scan(/^\d/).empty?
        Entities::MajorArcana.new(id)
      end

      def cards
        @cards
      end

      def set_value_of(cards)
        return build_deck_from(cards) unless cards.nil?
        []
      end

    end
  end
end
