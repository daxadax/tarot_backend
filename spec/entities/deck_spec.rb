require 'spec_helper'

class DeckSpec < EntitySpec
  let(:nickname) { nil }
  let(:deck) { Entities::Deck.new(nickname) }

  describe "creation" do
    it "gives the deck a default name if none is provided" do
      assert_equal :rider_waite, deck.name
    end

    describe "with optional arguments" do
      let(:nickname) { :herbal }

      it "can give a deck a name" do
        assert_equal nickname, deck.name
      end

      describe "unrecognized deck name" do
        let(:nickname) { :unknown_deck }

        it "fails if the deck is unknown" do
          assert_failure {deck}
        end
      end
    end
  end

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