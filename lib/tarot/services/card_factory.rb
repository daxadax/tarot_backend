require 'csv'

module Tarot
  module Services
    class CardFactory < Service

      def initialize
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
          :golden_dawn => golden_dawn[card[:id]]
        }

        Entities::Correspondence.new(options)
      end

      def golden_dawn
        @gd ||= csv_mapper.map_correspondence(:golden_dawn)
      end

      def csv_mapper
        @mapper ||= Services::CsvMapper.new
      end

    end
  end
end
