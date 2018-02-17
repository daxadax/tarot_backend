require 'spec_helper'

class GetCardsSpec < UseCaseSpec
  let(:quantity) { 3 }
  let(:cards) { nil }

  let(:spread) do
    input = {
      :quantity => quantity,
      :cards => cards,
    }

    UseCases::GetCards.new(input)
  end

  describe "calling" do
    let(:result) { spread.call }

    describe "with no input" do
      let(:quantity) { nil }

      it "returns the full deck" do
        assert_equal 78, result.cards.size
      end
    end

    it "returns attributes of the built spread" do
      assert_predicate result, :cards
      assert_predicate result, :count
    end

    it "returns the requested number of cards" do
      assert_equal 3, result.cards.size
    end

    it "returns statistics about the dealt spread" do
      assert_kind_of Hash, result.count
      result.count[0].each do |symbol, count|
        assert_kind_of Symbol, symbol
        assert_kind_of Integer, count
      end
    end

    describe "with cards pre-specified" do
      let(:cards) { %w[w_03 c_10 t_00] }

      it "returns those cards" do
        assert_equal 3, result.cards.size
        assert_equal cards.sort, result.cards.map(&:id).sort
      end
    end
  end

end
