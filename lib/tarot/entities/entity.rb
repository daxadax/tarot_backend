module Tarot
  module Entities
    class Entity
      include Support::ValidationHelpers

      private

      def suits
        %w[w p c s]
      end
    end
  end
end
