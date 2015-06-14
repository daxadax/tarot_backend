require 'csv'

module Tarot
  module Services
    class CsvMapper < Service
      def map_cards
        cards = parse_data(:cards)
        cards.map do |card|
          {
            :id => card[0],
            :arcana => card[1],
            :display_name => card[2],
            :elements => map_to_array(card[3]),
            :suit => card[4],
            :court => map_boolean(card[5].to_i),
            :astrological_signs => map_to_array(card[6])
          }
        end
      end

      def map_correspondence(filename)
        data = parse_data(filename)
        options = (filename == :golden_dawn ? {} : {symbolize_keys: true})
        data.inject({}) do |result, row|
          parse_row(result, row, options)
        end
      end

      private

      def parse_row(result, row, options = {})
        key = options[:symbolize_keys] ? row[0].to_sym : row[0]
        result[key] = row.last
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
        string.split(', ')
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
