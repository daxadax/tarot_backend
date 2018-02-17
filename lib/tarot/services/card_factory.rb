require 'csv'

module Tarot
  module Services
    class CardFactory < Service
      def initialize(options = {})
        @csv_mapper ||= Services::CsvMapper.new(options)
        @deck = options.fetch(:deck) { Tarot::DEFAULT_DECK }
        @cards = build_cards
      end

      def get(id)
        cards.detect { |card| card.id == id }
      end

      def get_multiple(ids)
        ids.map { |id| get(id) }
      end

      def all
        cards
      end

      private
      attr_reader :csv_mapper, :deck

      def cards
        @cards
      end

      def build_cards
        cards = csv_mapper.map_cards

        cards.map do |card|
          correspondence = build_correspondence(card)
          Entities::Card.new(card, correspondence).freeze
        end
      end

      def build_correspondence(card)
        options = {
          deck.to_sym => deck_correspondences[card[:id]]
        }

        Entities::Correspondence.new(options)
      end

      def deck_correspondences
        @dc ||= csv_mapper.map_correspondence(deck)
      end
    end
  end
end
