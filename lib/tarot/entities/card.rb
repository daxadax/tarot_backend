module Tarot
  module Entities
    class Card < Entity
      attr_reader :arcana

      def initialize(arcana)
        ensure_valid_arcana!(arcana)

        @arcana = arcana
      end

      def major?
        @arcana == :major
      end

      def minor?
        @arcana == :minor
      end

      private

      def ensure_valid_arcana!(arcana)
        ensure_required_input!(:arcana, arcana)
        wrong_value_error unless valid_arcana.include?(arcana)
      end

      def wrong_value_error
        reason = "Arcana can only be :major or :minor"
        raise_argument_error(reason, arcana)
      end

      def valid_arcana
        [
          :major,
          :minor
        ]
      end

    end
  end
end