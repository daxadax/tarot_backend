require 'bound'

module Tarot
  module UseCases
    class GetPlanetaryInfluence < UseCase
      Influence = Services::PlanetaryInfluenceBoundary::PlanetaryInfluence

      Input = Bound.optional(:time_of_reading)
      Result = Bound.required(:planetary_influence => Influence)

      def initialize(input)
        @input = Input.new(input)
        @time_of_reading = validate_and_return!(@input.time_of_reading)
      end

      def call
        Result.new(:planetary_influence => get_influence)
      end

      private

      def get_influence
        Services::PlanetaryInfluenceBoundary.new.at(time_of_reading)
      end

      def time_of_reading
        @time_of_reading
      end

      def validate_and_return!(time)
        return Time.now.utc unless time
        raise ArgumentError, "Time must be UTC" unless time.utc?
        time
      end
    end
  end
end
