require 'spec_helper'

class GetPlanetaryInfluenceSpec < UseCaseSpec
  let(:time_of_reading) { Time.utc(2015,2,3,4,20) }
  let(:use_case) do
    input = {
      :time_of_reading => time_of_reading
    }
    UseCases::GetPlanetaryInfluence.new(input)
  end
  let(:expected_boundary) do 
    Services::PlanetaryInfluenceBoundary::PlanetaryInfluence
  end

  describe 'calling' do 
    let(:result) { use_case.call }

    describe 'with no input' do 
      let(:time_of_reading) { nil }

      it 'returns information using the current time' do
        time_of_reading = use_case.send :time_of_reading

        assert_kind_of expected_boundary, result.planetary_influence
        assert_in_delta time_of_reading, Time.now.utc, 0.1
      end
    end

    describe 'with time given' do
      describe 'not as utc' do 
        let(:time_of_reading) { Time.new(1990,1,2) }
        it 'fails' do 
          exception = assert_raises(ArgumentError) { result }
          assert_includes exception.message, "must be UTC"
        end
      end

      describe 'as utc' do 
        it 'returns moon data for the given time' do 
          assert_kind_of expected_boundary, result.planetary_influence
        end
      end
    end
  end
end
