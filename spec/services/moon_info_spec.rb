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

    describe 'and is formatted correctly' do

      describe 'when full and waxing' do
        let(:_time) { Time.utc(2015,1,4) }

        it 'returns information about the current moon phase' do
          assert_equal 0.98, moon_info.illumination
          assert_equal true, moon_info.waxing?
          assert_equal false, moon_info.waning?
          assert_equal :full, moon_info.phase
        end
      end

      describe 'when full' do
        let(:_time) { Time.utc(2015,5,4) }

        it 'returns information about the current moon phase' do
          assert_equal 1.0, moon_info.illumination
          assert_equal true, moon_info.waxing?
          assert_equal false, moon_info.waning?
          assert_equal :full, moon_info.phase
        end
      end

      describe 'when full and waning' do
        let(:_time) { Time.utc(2015,3,7) }

        it 'returns information about the current moon phase' do
          assert_equal 0.99, moon_info.illumination
          assert_equal false, moon_info.waxing?
          assert_equal true, moon_info.waning?
          assert_equal :full, moon_info.phase
        end
      end

      describe 'when new and waning' do
        let(:_time) { Time.utc(2015,4,18) }

        it 'returns information about the current moon phase' do
          assert_equal 0.01, moon_info.illumination
          assert_equal false, moon_info.waxing?
          assert_equal true, moon_info.waning?
          assert_equal :new, moon_info.phase
        end
      end

      describe 'when new' do 
        let(:_time) { Time.utc(2015,4,19) }

        it 'returns information about the current moon phase' do 
          assert_equal 0, moon_info.illumination
          assert_equal :new, moon_info.phase
        end
      end

      describe 'when new and waxing' do
        let(:_time) { Time.utc(2015,4,20) }

        it 'returns information about the current moon phase' do
          assert_equal 0.02, moon_info.illumination
          assert_equal :new, moon_info.phase
          assert_equal true, moon_info.waxing?
          assert_equal false, moon_info.waning?
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
