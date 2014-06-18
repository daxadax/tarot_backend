require 'spec_helper'

class DeckSpec < EntitySpec
  let(:deck) { Entities::Deck.new }

  describe "dealing" do
    let(:result)      { deck.deal(9) }
    let(:result_two)  { deck.deal(9) }

    it "shuffles and deals a given number of cards" do
      assert_equal 9, result.size
      assert_equal 9, result_two.size

      refute_same result, result_two
    end
  end

end