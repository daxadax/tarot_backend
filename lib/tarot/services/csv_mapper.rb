require 'csv'

module Tarot
  module Services
    class CsvMapper < Service
      def map_cards
        cards = parse_data(:cards)
        cards.map do |card|
          {
            :id => card[0],
            :arcana => card[1].to_sym,
            :display_name => card[2],
            :elements => map_to_array(card[3]),
            :suit => card[4].to_sym,
            :court => map_boolean(card[5].to_i),
            :astrological_signs => map_to_array(card[6])
          }
        end
      end

      def map_correspondence(filename)
        data = parse_data(filename)
        data.inject({}) do |result, row|
          parse_row(result, row)
        end
      end

      private

      def parse_row(result, row)
        value = row.last.empty? ? nil : row.last

        result[row[0].to_sym] = value
        result
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

      def data
        @data
      end

    end
  end
end
