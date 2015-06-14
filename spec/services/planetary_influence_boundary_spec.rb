require 'spec_helper'

class PlanetaryInfluenceBoundarySpec < ServiceSpec
  let(:boundary) { Services::PlanetaryInfluenceBoundary.new }
  let(:time_of_reading) { Time.utc(2015, 2, 23) }
  let(:result) { boundary.at(time_of_reading) }

  it "grants access to 'ruling_signs'" do
    assert_equal [:aquarius, :pisces], result.ruling_signs
  end

  it "grants access to 'ruling_planets'" do
    assert_equal [:saturn, :jupiter], result.ruling_planets
  end

  it "grants access to 'decan_planet'" do
    assert_equal :jupiter, result.decan_planet
  end

  it "grants access to 'daily_planet'" do
    assert_equal :luna, result.daily_planet
  end

  it "grants access to 'yearly_planet'" do
    assert_equal :jupiter, result.yearly_planet
  end

  it "grants access to 'cyclic_planet'" do
    assert_equal :sol, result.cyclic_planet
  end
end
