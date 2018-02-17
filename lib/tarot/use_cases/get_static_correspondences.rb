require 'bound'

module Tarot
  module UseCases
    class GetStaticCorrespondences < UseCase
      Result = Bound.required(
        :astrological,
        :elemental
      )

      def initialize(options = {})
        @csv_mapper = Services::CsvMapper.new(options)
      end

      def call
        Result.new(
          :astrological => read(:astrological),
          :elemental => read(:elemental)
        )
      end

      private

      def read(filename)
        csv_mapper.map_correspondence(filename, symbolize_keys: true)
      end

      def csv_mapper
        @csv_mapper
      end
    end
  end
end
