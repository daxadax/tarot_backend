require 'spec_helper'

class DeckSpec < EntitySpec
  let(:deck) { Entities::Deck.new }

  describe "dealing" do
    describe "without a given number of cards" do
      let(:result) { deck.deal }

      it "returns the whole deck" do
        assert_equal 78, result.size
      end
    end

    describe "with a given number of cards" do
      let(:result)      { deck.deal(9) }
      let(:result_two)  { deck.deal(6) }

      it "shuffles and deals the given number of cards" do
        assert_equal 9, result.size
        assert_equal 6, result_two.size

        refute_same result, result_two
      end
    end
  end

end