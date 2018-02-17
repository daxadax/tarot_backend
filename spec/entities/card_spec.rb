require "spec_helper"

class CardSpec < EntitySpec
  let(:card) { build_card }

  it "builds a card" do
    assert_kind_of Entities::Card, card
    assert_equal 't_07', card.id
    assert_equal 'major', card.arcana
    assert_equal 'The Chariot', card.display_name
    assert_equal ['water'], card.elements
    assert_equal 'trumps', card.suit
    assert_equal ['cancer'], card.astrological_signs
  end

  it 'sets correspondence' do
    assert_includes card.correspondence.marseille, 'marseille'
  end

  describe "major?/minor?" do
    it "determines the type of card" do
      assert_equal true,  card.major?
      assert_equal false, card.minor?
    end
  end

  describe "court?" do
    let(:court_card_options) do
      {
        :id => 'c_14',
        :arcana => 'minor',
        :display_name => 'King of Cups',
        :elements => ['water'],
        :suit => 'cups',
        :court => true,
        :astrological_signs => ['cancer']
      }
    end
    let(:court_card) do
      build_card attributes: court_card_options
    end

    it "determines if the card is a court card" do
      assert_equal false, card.court?
      assert_equal true, court_card.court?
    end
  end
end
