require 'spec_helper'

class CardBoundarySpec < ServiceSpec
  let(:card_factory) { Services::CardFactory.new }
  let(:minor_id) { 'c_13' }
  let(:major_id) { '07' }
  let(:minor) { card_factory.get(minor_id) }
  let(:major) { card_factory.get(major_id) }
  let(:boundary) { Services::CardBoundary.new }
  let(:minor_result) { boundary.for(minor) }
  let(:major_result) { boundary.for(major) }

  it "grants access to id" do
    assert_equal minor_id, minor_result.id
    assert_equal major_id, major_result.id
  end

  it "grants access to 'arcana'" do
    assert_equal :minor,  minor_result.arcana
    assert_equal :major,  major_result.arcana
  end

  it "grants access to 'display_name" do
    assert_equal 'Queen of Cups', minor_result.display_name
    assert_equal 'The Chariot', major_result.display_name
  end

  it "grants access to 'suit'" do
    assert_equal :cups, minor_result.suit
    assert_equal :trumps, major_result.suit
  end

  it "grants access to 'element'" do
    assert_equal [:water], minor_result.element
    assert_equal [:water], major_result.element
  end

  it "grants access to 'astrological_signs'" do
    assert_equal [:scorpio], minor_result.astrological_signs
    assert_equal [:cancer], major_result.astrological_signs
  end

  it "grants access to 'correspondence'" do
    assert_includes minor_result.correspondence, 'desire'
    assert_includes major_result.correspondence, 'inner conviction'
  end

  it "grants access to 'elemental_correspondence'" do
    assert_includes minor_result.elemental_correspondence, 'social'
    assert_includes major_result.elemental_correspondence, 'social'
  end

  it "grants access to 'golden_dawn_correspondence'" do
    assert_empty minor_result.golden_dawn_correspondence
    assert_includes major_result.golden_dawn_correspondence, 'speech'
  end

  it "grants access to helper methods" do
    assert_equal true,  minor_result.is_minor
    assert_equal false, minor_result.is_major
    assert_equal false, major_result.is_minor
    assert_equal true,  major_result.is_major

    assert_equal true, minor_result.is_court_card
    assert_equal false, major_result.is_court_card
  end

end
