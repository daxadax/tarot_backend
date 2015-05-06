require 'csv'

module Tarot
  module Services
    class CardFactory < Service

      def initialize
        @cards = DeckBuilder.new.build
      end

      def get(id)
        cards[id]
      end

      def get_multiple(ids)
        ids.map { |id| get(id) }
      end

      def all
        cards.values
      end

      private

      def cards
        @cards
      end

      class DeckBuilder
        def initialize
          @deck = Hash.new
          @card_data = parse_data 'cards'
          @general = parse_data 'general'
          @elemental = parse_data 'elemental'
          @golden_dawn = parse_data 'golden_dawn'
        end

        def build
          cards.each do |attributes|
            correspondence = correspondence_for(attributes)
            card = Entities::Card.new(attributes, correspondence).freeze
            @deck[card.id] = card
          end
          @deck
        end

        private

        def cards
          @card_data.map do |attributes|
            {
              :id => attributes[0],
              :arcana => attributes[1].to_sym,
              :display_name => attributes[2],
              :element => map_to_array(attributes[3]),
              :suit => attributes[4].to_sym,
              :court => map_boolean(attributes[5].to_i),
              :astrological_signs => map_to_array(attributes[6])
            }
          end
        end

        def parse_data(name)
          path = data_path(name)
          CSV.read(path)[1..-1]
        end

        def data_path(name)
          relative = "../../../../data/#{name}.csv"
          File.expand_path relative, __FILE__
        end

        def map_to_array(string)
          string.split(', ').map(&:to_sym)
        end

        def map_boolean(int)
          int.zero? ? false : true
        end

        def correspondence_for(card)
          attributes = {
            :general => fetch_correspondence(@general, card[:id]),
            :elemental => card[:element].flat_map do |element|
              fetch_correspondence(@elemental, element.to_s)
            end,
            :golden_dawn => fetch_correspondence(@golden_dawn, card[:id])
          }

          Entities::Correspondence.new(attributes)
        end

        def fetch_correspondence(data, id)
          c = data.detect { |row| row[0] == id }
          c[1].split(', ') unless c.nil?
        end

      end
    end
  end
end
