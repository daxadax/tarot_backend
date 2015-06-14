require 'spec_helper'

class PlanetaryInfluenceSpec < ServiceSpec

  let(:service) { Services::PlanetaryInfluence.new(time_of_reading) }
  let(:time_of_reading) { Time.utc(2001,2,23,16,20) }
  let(:result) { service.calculate }

  describe 'when time is not given' do
    let(:time_of_reading) { nil }

    it 'uses the current time' do
      time = service.send :time_of_reading
      assert_in_delta time, Time.now.utc, 1
    end
  end

  describe 'when the time is not given as utc' do 
    let(:time_of_reading) { Time.new(2000,2,23) }
    
    it 'raises an error' do 
      exception = assert_raises(ArgumentError) { result }
      assert_includes exception.message, "given as UTC"
    end
  end

  it 'determines significant influences for the time of reading' do
    assert_equal [:aquarius, :pisces], result.ruling_signs
    assert_equal [:saturn, :jupiter], result.ruling_planets
    assert_equal :jupiter, result.decan_planet
    assert_equal :venus, result.daily_planet
    assert_equal :jupiter, result.yearly_planet
    assert_equal :sun, result.cyclic_planet
  end

  describe 'on a leap year' do 
    let(:time_of_reading) { Time.utc(1988,5,19) }
    
    it 'accounts for the time difference' do
      assert_equal [:taurus, :gemini], result.ruling_signs
      assert_equal [:venus, :mercury], result.ruling_planets
      assert_equal :saturn, result.decan_planet
      assert_equal :jupiter, result.daily_planet
      assert_equal :sun, result.yearly_planet
      assert_equal :sun, result.cyclic_planet  
    end
  end

end
