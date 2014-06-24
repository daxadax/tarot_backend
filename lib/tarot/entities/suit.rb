module Tarot
  module Entities
    class Suit < Entity
      attr_reader :name, :associations

      def initialize
        @name         = build_suit_name
        @associations = Array.new(default_associations)
      end

      def add_associations(new_associations)
        ensure_valid_associations!(new_associations)

        new_associations.each { |a| @associations << a }
      end

      private

      def default_associations
        SUIT_ASSOCIATIONS[@name.downcase.to_sym]
      end

      def build_suit_name
        (self.class.name.split('::').last)
      end

      def ensure_valid_associations!(associations)
        unless associations.kind_of? Array
          reason = "Associations must be given as an array"

          raise_argument_error reason, associations
        end
      end

    end
  end
end