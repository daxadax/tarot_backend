require 'bound'

module Tarot
  module UseCases
    class GetMoonInfo < UseCase
      Moon = Services::MoonBoundary::Moon

      Input = Bound.optional(:time_of_reading)
      Result = Bound.required(:moon => Moon)

      def initialize(input)
        @input = Input.new(input)
        @time_of_reading = validate_and_return!(@input.time_of_reading)
      end

      def call
        Result.new(:moon => build_moon_info)
      end

      private

      def build_moon_info
        Services::MoonBoundary.new.at(time_of_reading)
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
