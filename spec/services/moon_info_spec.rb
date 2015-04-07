require 'spec_helper'

class MoonInfoSpec < ServiceSpec
  let(:_time) { nil }
  let(:moon_info) { Services::MoonInfo.new(_time) }

  describe 'when time is given' do
    describe 'and is not UTC' do
      let(:_time) { Time.new(2010,3,1) }

      it 'fails' do
        exception = assert_failure { moon_info }
        assert_includes exception.message, "must be UTC"
      end
    end

    describe 'and is before January 2000' do
      let(:_time) { Time.utc(1999, 12, 31) }

      it 'fails' do
        exception = assert_failure { moon_info }
        assert_includes exception.message, "after 2000"
      end
    end

    describe 'and is formatted correctly' do
      describe 'when full and waning' do
        let(:_time) { Time.utc(2015,4,5) }

        it 'returns information about the current moon phase' do
          assert_equal 15.36, moon_info.age
          assert_equal 0.97, moon_info.illumination
          assert_equal :full, moon_info.phase
          assert_equal false, moon_info.waxing?
          assert_equal true, moon_info.waning?
        end
      end

      describe 'when full and waxing' do
        let(:_time) { Time.utc(2015,4,4) }

        it 'returns information about the current moon phase' do
          assert_equal 14.17, moon_info.age
          assert_equal 0.95, moon_info.illumination
          assert_equal :full, moon_info.phase
          assert_equal true, moon_info.waxing?
          assert_equal false, moon_info.waning?
        end
      end

      describe 'when new and waning' do
        let(:_time) { Time.utc(2015,4,19) }

        it 'returns information about the current moon phase' do
          assert_equal 29.24, moon_info.age
          assert_equal 0.04, moon_info.illumination
          assert_equal :new, moon_info.phase
          assert_equal false, moon_info.waxing?
          assert_equal true, moon_info.waning?
        end
      end

      describe 'when new and waxing' do
        let(:_time) { Time.utc(2015,4,20) }

        it 'returns information about the current moon phase' do
          assert_equal 0.89, moon_info.age
          assert_equal 0.06, moon_info.illumination
          assert_equal :new, moon_info.phase
          assert_equal true, moon_info.waxing?
          assert_equal false, moon_info.waning?
        end
      end
    end
  end

  describe 'when time is not given' do
    it 'the current time is used' do
      result = moon_info.send :time
      assert_in_delta Time.now, result, 1
    end
  end

end
