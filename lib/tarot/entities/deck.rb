module Tarot
  module Entities
    class Deck < Entity
      attr_reader :name

      def initialize(name = nil)
        ensure_valid_deck_name!(name) unless name.nil?

        @name   = name || AVAILABLE_DECKS.first
        @cards  = []
      end

      def deal(number = 9)
        build_new_deck

        cards.shuffle.pop(number)
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

      def ensure_valid_deck_name!(name)
        unless AVAILABLE_DECKS.include?(name)
          reason = "#{name} is not an available deck"
          raise_argument_error(reason, name)
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
