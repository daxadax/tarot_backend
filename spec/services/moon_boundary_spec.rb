require 'spec_helper'

class MoonBoundarySpec < ServiceSpec
  let(:boundary) { Services::MoonBoundary.new }
  let(:time_of_reading) { Time.utc(2015, 2, 23) }
  let(:result) { boundary.at(time_of_reading) }

  it "grants access to 'phase'" do
    assert_equal :crescent, result.phase
  end

  it "grants access to 'illumination'" do
    assert_equal 0.22, result.illumination
  end

  it "grants access to 'active_elements' as strings" do
    assert_equal ['earth', 'air'], result.active_elements
  end

  it "grants access to 'is_waxing'" do
    assert_equal true, result.is_waxing
  end

  it "grants access to 'is_waning'" do
    assert_equal false, result.is_waning
  end
end
