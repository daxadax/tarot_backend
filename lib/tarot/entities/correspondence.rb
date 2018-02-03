module Tarot
  module Entities
    class Correspondence < Entity
      attr_reader :golden_dawn

      def initialize(options)
        @golden_dawn = set_attribute options, :golden_dawn
      end

      private

      def set_attribute(options, name)
        options.fetch(name) do
          msg = "Missing required correspondence: #{name}"
          raise ArgumentError, msg
        end
      end
    end
  end
end
