require 'spec_helper'

class DeckSpec < EntitySpec
  let(:cards)   { nil }
  let(:deck)    { Entities::Deck.new(cards) }
  let(:result)  { deck.deal }

  describe "dealing from a full deck" do
    describe "without a given number of cards" do
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

  describe "a given hand" do

    describe "with unknown cards specified" do
      let(:cards) { ['w_2000', 'wands_5'] }

      it "fails" do
        assert_failure { result }
      end
    end

    describe "with known cards specified" do
      let(:cards) { ['w_05', '00', 'p_14'] }

      it "returns the specified cards" do
        assert_equal 3,                   result.count
        assert_equal known_card_names[0], result[0].display_name
        assert_equal known_card_names[1], result[1].display_name
        assert_equal known_card_names[2], result[2].display_name
      end

      it "can deal a specified subset of the cards" do
        result = deck.deal(1)
        assert_equal 1, result.count
        assert_includes known_card_names, result[0].display_name
      end
    end

    def known_card_names
      [
        'Five of Wands',
        'The Fool',
        'King of Pentacles'
      ]
    end

  end

end