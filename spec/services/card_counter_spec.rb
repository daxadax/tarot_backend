require 'spec_helper'

class CardCounterSpec < ServiceSpec
  let(:cards) { Services::CardFactory.new.all }
  let(:card_counter) { Services::CardCounter.new(cards) }

  describe "count" do
    let(:result) { card_counter.count }

    it "returns stats about the given cards" do
      assert_equal 22, result.trumps
      assert_equal 14, result.wands
      assert_equal 14, result.pentacles
      assert_equal 14, result.cups
      assert_equal 14, result.swords
      assert_equal 16, result.court_cards
    end
  end

  describe "average" do
    let(:result) { card_counter.average }

    it "returns the average number of cards by type" do
      assert_equal 28, result.trumps
      assert_equal 18, result.wands
      assert_equal 18, result.pentacles
      assert_equal 18, result.cups
      assert_equal 18, result.swords
      assert_equal 21, result.court_cards
    end
  end

end
