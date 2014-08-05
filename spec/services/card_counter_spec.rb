require 'spec_helper'

class CardCounterSpec < ServiceSpec
  let(:cards)         { nil }
  let(:deck)          { Entities::Deck.new(cards).deal }
  let(:card_counter)  { Services::CardCounter.new(deck) }

  describe "count" do
    let(:result)        { card_counter.count }

    it "returns stats about the given cards" do
      assert_equal 22, result.major
      assert_equal 14, result.wands
      assert_equal 14, result.pentacles
      assert_equal 14, result.cups
      assert_equal 14, result.swords
      assert_equal 16, result.court_cards
      assert_kind_of Integer, result.reversed
    end
  end

  describe "average" do
    let(:result) { card_counter.average }

    it "returns the average number of cards by type" do
      assert_equal 28, result.major
      assert_equal 18, result.wands
      assert_equal 18, result.pentacles
      assert_equal 18, result.cups
      assert_equal 18, result.swords
      assert_equal 21, result.court_cards
      assert_kind_of Integer, result.reversed
    end
  end

  describe "average_over_threshold" do
    let(:cards)     { ['w_10', '00', '05'] }
    let(:result)    { card_counter.average_over_threshold(threshold) }

    describe "when the avg of at least one card type is over the threshold" do
      let(:threshold) { 25 }

      it "returns true" do
        assert_equal true, result
      end
    end

    describe "when no cardsrd type returns an avg greater than the threshold" do
      let(:threshold) { 70 }

      it "returns false" do
        assert_equal false, result
      end
    end
  end

end
