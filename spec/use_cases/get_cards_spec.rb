require 'spec_helper'

class GetCardsSpec < UseCaseSpec
  let(:quantity) { 3 }
  let(:cards) { nil }

  let(:spread) do
    input = {
      :quantity => quantity,
      :cards => cards
    }

    UseCases::GetCards.new(input)
  end

  describe "calling" do
    let(:result) { spread.call }
    let(:stat_types) do
      [:wands, :pentacles, :cups, :swords, :trumps]
    end

    describe "with no input" do
      let(:quantity) { nil }

      it "returns the full deck" do
        assert_equal 78, result.cards.size
      end
    end

    it "returns attributes of the built spread" do
      assert_predicate result, :cards
      assert_predicate result, :count
      assert_predicate result, :average
    end

    it "returns the right number of cards for the used spread" do
      assert_equal 3, result.cards.size
    end

    it "returns statistics about the dealt spread" do
      stat_types.each do |stat|
        assert_kind_of Integer, result.count.public_send(stat)
        assert_kind_of Integer, result.average.public_send(stat)
      end
    end

    it "returns the correct stats for the dealt spread" do
      assert_equal expected_size, result.count.trumps
      assert_equal expected_average, result.average.trumps
    end

    def expected_size
      result.cards.select(&:is_major).size
    end

    def expected_average
      (result.count.trumps/result.cards.size.to_f * 100).round
    end

    describe "with cards pre-specified" do
      let(:cards) { %w[w_03 c_10 00] }

      it "returns those cards" do
        assert_equal 3, result.cards.size
        assert_equal cards.sort, result.cards.map(&:id).sort
      end
    end
  end

end