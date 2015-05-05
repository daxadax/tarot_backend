module Tarot
  module UseCases
    class UseCase
      include Support::ValidationHelpers

      def card_factory
        @card_factory ||= Services::CardFactory.new
      end
    end
  end
end
