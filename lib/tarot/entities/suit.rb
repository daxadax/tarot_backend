module Tarot
  module Entities
    class Suit < Entity
      attr_reader :name, :element, :domain

      def initialize
        @name         = build_suit_name
        @element      = suit_element
        @domain = Array.new(default_domain)
      end

      def add_domain(new_domain)
        ensure_valid_domain!(new_domain)

        new_domain.each { |a| @domain << a }
      end

      private

      def build_suit_name
        (self.class.name.split('::').last)
      end

      def suit_element
        suit_attributes.element
      end

      def default_domain
        suit_attributes.domain
      end

      def suit_attributes
        SUITS[@name.downcase.to_sym]
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