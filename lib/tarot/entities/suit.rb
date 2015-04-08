module Tarot
  module Entities
    class Suit < Entity
      attr_reader :name, :element, :domain

      def initialize
        @name = build_suit_name
        @element = elements[name]
        @domain = association_factory.elemental(element)
      end

      private

      def build_suit_name
        self.class.name.split('::').last
      end

      def elements
        {
          'Wands' => :fire,
          'Pentacles' => :earth,
          'Cups' => :water,
          'Swords' => :air
        }
      end

      def ensure_valid_domain!(domain)
        unless domain.kind_of? Array
          reason = "Domain must be given as an array"

          raise_argument_error reason, domain
        end
      end

    end
  end
end
