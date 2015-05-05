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
    assert_equal :minor, card.arcana
    assert_equal 'Knight of Wands', card.display_name
    assert_equal [:fire, :earth], card.element
    assert_equal :wands, card.suit
    assert_equal [:leo, :sagittarius], card.astrological_signs
    assert_equal true, card.court?
  end

  it 'can fetch several cards' do
    ids = %w{ w_12' 20 s_01 c_10 }
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

    assert_equal '21', card.id
    assert_equal :major, card.arcana
    assert_equal 'The World', card.display_name
    assert_equal [:earth], card.element
    assert_equal :trumps, card.suit
    assert_equal [:saturn], card.astrological_signs
    assert_equal false, card.court?
    assert_includes card.correspondence.general, 'essence'
    assert_includes card.correspondence.elemental, 'financial'
    assert_includes card.correspondence.golden_dawn,
      'universal consciousness'
  end
end
