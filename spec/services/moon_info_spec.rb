require 'spec_helper'

class MoonInfoSpec < ServiceSpec
  let(:_time) { nil }
  let(:moon_info) { Services::MoonInfo.new(_time) }

  # expected values: 
  # http://aa.usno.navy.mil/data/docs/MoonFraction.php  ## for illumination

  describe 'when time is given' do
    describe 'and is not UTC' do
      let(:_time) { Time.new(2010,3,1) }

      it 'fails' do
        exception = assert_failure { moon_info }
        assert_includes exception.message, "must be UTC"
      end
    end

    describe 'and no data is available' do
      it 'pulls the data??' do
        skip
      end
    end

    describe 'and is formatted correctly' do

      describe 'new' do 
        let(:_time) { Time.utc(2015,4,19) }

        it 'returns information about the current moon phase' do 
          assert_equal 0, moon_info.illumination
          assert_equal false, moon_info.waxing?
          assert_equal false, moon_info.waning?
          assert_equal :new, moon_info.phase
        end
      end

      describe 'crescent' do
        let(:_time) { Time.utc(2015,4,20) }

        it 'returns information about the current moon phase' do
          assert_equal 0.02, moon_info.illumination
          assert_equal :crescent, moon_info.phase
          assert_equal true, moon_info.waxing?
          assert_equal false, moon_info.waning?
        end
      end
 
      describe 'first quarter' do
        let(:_time) { Time.utc(2015,8,23) }

        it 'returns information about the current moon phase' do
          assert_equal 0.52, moon_info.illumination
          assert_equal true, moon_info.waxing?
          assert_equal false, moon_info.waning?
          assert_equal :first_quarter, moon_info.phase
        end
      end

      describe 'gibbous' do
        let(:_time) { Time.utc(2015,1,4) }

        it 'returns information about the current moon phase' do
          assert_equal 0.98, moon_info.illumination
          assert_equal true, moon_info.waxing?
          assert_equal false, moon_info.waning?
          assert_equal :gibbous, moon_info.phase
        end
      end

      describe 'full' do
        let(:_time) { Time.utc(2015,5,4) }

        it 'returns information about the current moon phase' do
          assert_equal 1.0, moon_info.illumination
          assert_equal false, moon_info.waxing?
          assert_equal false, moon_info.waning?
          assert_equal :full, moon_info.phase
        end
      end

      describe 'disseminating' do
        let(:_time) { Time.utc(2015,3,7) }

        it 'returns information about the current moon phase' do
          assert_equal 0.99, moon_info.illumination
          assert_equal false, moon_info.waxing?
          assert_equal true, moon_info.waning?
          assert_equal :disseminating, moon_info.phase
        end
      end

      describe 'last quarter' do 
        let(:_time) { Time.utc(2015,6,10) }

        it 'returns information about the current moon phase' do
          assert_equal 0.46, moon_info.illumination
          assert_equal false, moon_info.waxing?
          assert_equal true, moon_info.waning?
          assert_equal :last_quarter, moon_info.phase
        end
      end

      describe 'balsamic' do
        let(:_time) { Time.utc(2015,4,18) }

        it 'returns information about the current moon phase' do
          assert_equal 0.01, moon_info.illumination
          assert_equal false, moon_info.waxing?
          assert_equal true, moon_info.waning?
          assert_equal :balsamic, moon_info.phase
        end
      end

   end
  end

  describe 'when time is not given' do
    it 'the current time is used' do
      result = moon_info.instance_variable_get :@current_time
      assert_in_delta Time.now, result, 1
    end
  end

end
