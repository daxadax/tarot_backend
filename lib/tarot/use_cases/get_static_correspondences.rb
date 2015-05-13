require 'bound'

module Tarot
  module UseCases
    class GetStaticCorrespondences < UseCase
      Result = Bound.required(
        :astrological,
        :elemental,
        :rank
      )

      def initialize
        @csv_mapper = Services::CsvMapper.new
      end

      def call
        Result.new(
          :astrological => read(:astrological),
          :elemental => read(:elemental),
          :rank => read(:rank)
        )
      end

      private

      def read(filename)
        csv_mapper.map_correspondence(filename)
      end

      def csv_mapper
        @csv_mapper 
      end

    end
  end
end
