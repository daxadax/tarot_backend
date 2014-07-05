require 'spec_helper'

class BuildSpreadSpec < UseCaseSpec
  let(:used_spread) { :enneagram }
  let(:spread) do
    UseCases::BuildSpread.new(used_spread)
  end

  describe "calling" do
    let(:result)      { spread.call }
    let(:stat_types) do
      [:wands, :pentacles, :cups, :swords, :major]
    end

    it "returns attributes of the built spread" do
      assert_predicate result, :cards
      assert_predicate result, :stats
    end

    it "returns the right number of cards for the used spread" do
      assert_equal 9, result.cards.size
    end

    it "returns statistics about the dealt spread" do
      stat_types.each do |stat|
        assert_kind_of Integer, result.stats[stat]
      end
    end

    it "returns the correct count for the dealt spread" do
      assert_equal result.cards.select(&:major?).size, result.stats.major
    end

    describe "with an unknown spread" do
      let(:used_spread) { :something_unknown }

      it "fails" do
        assert_failure {result}
      end
    end
  end

end