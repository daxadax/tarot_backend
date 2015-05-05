module Tarot
  module Entities
    class Card < Entity
      attr_reader :id,
        :arcana,
        :display_name,
        :element,
        :suit,
        :astrological_signs,
        :correspondence

      def initialize(attributes, correspondence)
        @id = set_attribute attributes, :id
        @arcana = set_attribute attributes, :arcana
        @display_name = set_attribute attributes, :display_name
        @element = set_attribute attributes, :element
        @suit = set_attribute attributes, :suit
        @astrological_signs = set_attribute attributes, :astrological_signs
        @court_card = attributes[:court]
        @correspondence = set_correspondence(correspondence)
      end

      def major?
        @arcana == :major
      end

      def minor?
        @arcana == :minor
      end

      def court?
        @court_card
      end

      private

      def set_attribute(attributes, name)
        attributes.fetch(name) do
          raise ArgumentError, "Missing #{name}"
        end
      end

      def set_correspondence(correspondence)
        unless correspondence.is_a? Entities::Correspondence
          msg = "Expected Correspondence object, got #{correspondence}"
          raise ArgumentError, correspondence
        end

        correspondence
      end
    end
  end
end
