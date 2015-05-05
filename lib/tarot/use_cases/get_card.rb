require 'bound'

module Tarot
  module UseCases
    class GetCard < UseCase

      Card = Services::CardBoundary::Card
      Input = Bound.required :card_id
      Result = Bound.required(:card => Card)

      def initialize(input)
        input = Input.new(input)
        @card_id = input.card_id
      end

      def call
        Result.new(:card => card_boundary.for(card))
      end

      private

      def card
        card_factory.get(@card_id)
      end

      def card_boundary
        Services::CardBoundary.new
      end

    end
  end
end
