require 'spec_helper'

class CardCounterSpec < ServiceSpec
  let(:cards)         { Entities::Deck.new.deal }
  let(:card_counter)  { Services::CardCounter.new(cards) }
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
