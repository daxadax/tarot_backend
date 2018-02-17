require 'spec_helper'

class GetCardSpec < UseCaseSpec
  let(:card_id) { 't_00' }

  let(:use_case) do
    input = {
      :card_id => card_id
    }

    UseCases::GetCard.new(input)
  end

  describe "calling" do
    let(:result) { use_case.call }

    it "returns the requested card" do
      assert_kind_of Services::CardBoundary::Card, result.card
      assert_equal card_id, result.card.id
      assert_equal :major, result.card.arcana
    end
  end
end
