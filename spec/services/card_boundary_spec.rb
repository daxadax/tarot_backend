require 'spec_helper'

class CardBoundarySpec < ServiceSpec
  let(:minor_id)      { 'c_13' }
  let(:major_id)      { '00' }
  let(:minor)         { Entities::MinorArcana.new(minor_id) }
  let(:major)         { Entities::MajorArcana.new(major_id) }
  let(:boundary)      { Services::CardBoundary.new }
  let(:minor_result)  { boundary.for(minor) }
  let(:major_result)  { boundary.for(major) }

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
    assert_equal 'The Fool',      major_result.display_name
  end

  it "grants access to 'domain'" do
    assert_includes minor_result.domain, 'social'
    assert_includes major_result.domain, 'communication'
  end

  it "grants access to associations" do
    assert_includes minor_result.associations, 'desire'
    assert_includes major_result.associations, 'amor fati'
  end

  it "grants access to 'suit'" do
    assert_equal 'Cups',  minor_result.suit
    assert_equal 'Trump', major_result.suit
  end

  it "grants access to 'element'" do
    assert_equal :water, minor_result.element
    assert_equal :air,   major_result.element
  end

  it "grants access to helper methods" do
    assert_equal true,  minor_result.is_minor
    assert_equal false, minor_result.is_major
    assert_equal false, major_result.is_minor
    assert_equal true,  major_result.is_major

    assert minor_result, :is_reversed
    assert major_result, :is_reversed

    assert_equal true,  minor_result.is_court_card
    assert_equal false, major_result.is_court_card
  end

end