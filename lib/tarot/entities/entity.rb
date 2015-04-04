module Tarot
  module Entities
    class Entity
      include Support::ValidationHelpers

      private

      def association_factory
        Tarot.association_factory
      end

      def suits
        %w[w p c s]
      end
    end
  end
end
