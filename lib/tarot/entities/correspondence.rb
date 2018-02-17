module Tarot
  module Entities
    class Correspondence < Entity
      attr_reader :marseille, :rider_waite_smith

      def initialize(options = {})
        @marseille = options.fetch(:marseille) { [] }
        @rider_waite_smith = options.fetch(:rider_waite_smith) { [] }
      end
    end
  end
end
