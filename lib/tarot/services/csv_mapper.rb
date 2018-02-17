require 'csv'

module Tarot
  module Services
    class CsvMapper < Service
      def initialize(options = {})
        @deck = options.fetch(:deck) { Tarot::DEFAULT_DECK }
      end

      def map_cards
        cards = parse_data('cards', deck)
        cards.map do |card|
          {
            id: card[0],
            arcana: card[1],
            display_name: card[2],
            elements: map_to_array(card[3]),
            suit: card[4],
            court: map_boolean(card[5].to_i),
            astrological_signs: map_to_array(card[6])
          }
        end
      end

      def map_correspondence(filename, options = {})
        data = parse_data('correspondence', filename)
        data.inject({}) do |result, row|
          key = options[:symbolize_keys] ? row[0].to_sym : row[0]
          result[key] = row.last
          result
        end
      end

      private
      attr_reader :deck

      def parse_data(subset, name)
        path = data_path(subset, name)
        CSV.read(path)[1..-1]
      end

      def data_path(subset, name)
        relative = "../../../../data/#{subset}/#{name}.csv"
        File.expand_path relative, __FILE__
      end

      def map_to_array(string)
        string.split(', ')
      end

      def map_boolean(int)
        int.zero? ? false : true
      end
    end
  end
end
