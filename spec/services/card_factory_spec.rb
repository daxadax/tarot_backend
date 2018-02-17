require 'spec_helper'

class CardFactorySpec < ServiceSpec
  let(:factory) { Services::CardFactory.new }
  let(:deck) { factory.all }

  it 'builds a full tarot deck' do
    assert_equal 78, deck.size
  end

  it 'can fetch a single card' do
    card = factory.get('w_12')

    assert_kind_of Entities::Card, card
    assert_equal 'w_12', card.id
    assert_equal 'minor', card.arcana
    assert_equal 'Queen of Wands', card.display_name
    assert_equal ['fire', 'water'], card.elements
    assert_equal 'wands', card.suit
    assert_equal ['leo'], card.astrological_signs
    assert_equal true, card.court?
  end

  it 'can fetch several cards' do
    ids = %w{ w_12 t_20 s_01 c_10 }
    cards = factory.get_multiple(ids)

    assert_equal 4, cards.size
  end

  it 'deep freezes all cards' do
    deck.each do |card|
      assert_predicate card, :frozen?
    end
  end

  it 'imports card objects' do
    assert_kind_of Entities::Card, deck.first
  end

  it 'correctly sets all attributes' do
    card = deck.last

    assert_equal 't_21', card.id
    assert_equal 'major', card.arcana
    assert_equal 'LE MONDE', card.display_name
    assert_empty card.elements
    assert_equal 'trumps', card.suit
    assert_empty card.astrological_signs
    assert_equal false, card.court?
    assert_includes card.correspondence.marseille,
      'great and total realization'
  end
end
