module Tarot
  module Entities
    class Suit < Entity
      attr_reader :associations

      def initialize
        @associations = []
      end

      def add_associations(new_associations)
        ensure_valid_associations!(new_associations)

        new_associations.each { |a| @associations << a }
      end

      private

      def ensure_valid_associations!(associations)
        unless associations.kind_of? Array
          reason = "Associations must be given as an array"

          raise_argument_error reason, associations
        end
      end

    end
  end
end