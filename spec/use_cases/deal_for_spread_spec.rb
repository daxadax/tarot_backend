require 'spec_helper'

class DealForSpreadSpec < UseCaseSpec
  let(:used_spread) { :enneagram }
  let(:spread) do
    UseCases::DealForSpread.new(used_spread)
  end

  describe "calling" do
    let(:result)      { spread.call }
    let(:stat_types) do
      [:wands, :pentacles, :cups, :swords, :trumps]
    end

    it "returns attributes of the built spread" do
      assert_predicate result, :cards
      assert_predicate result, :count
      assert_predicate result, :average
    end

    it "returns the right number of cards for the used spread" do
      assert_equal 9, result.cards.size
    end

    it "returns statistics about the dealt spread" do
      stat_types.each do |stat|
        assert_kind_of Integer, result.count.public_send(stat)
        assert_kind_of Integer, result.average.public_send(stat)
      end
    end

    it "returns the correct stats for the dealt spread" do
      assert_equal expected_size,     result.count.trumps
      assert_equal expected_average,  result.average.trumps
    end

    def expected_size
      result.cards.select(&:is_major).size
    end

    def expected_average
      (result.count.trumps/result.cards.size.to_f * 100).round
    end

    describe "with an unknown spread" do
      let(:used_spread) { :something_unknown }

      it "fails" do
        assert_failure {result}
      end
    end
  end

end