require 'spec_helper'

class CsvMapperSpec < ServiceSpec
  let(:reader) { Services::CsvMapper.new }

  describe 'map_cards' do
    let(:result) { reader.map_cards }

    it 'returns the correct number of cards' do
      assert_equal 78, result.size
    end

    it 'maps each value to the correct attribute' do
      card = result.detect { |c| c[:id] == '13' }

      assert_equal 'major', card[:arcana]
      assert_equal 'Death', card[:display_name]
      assert_equal ['water'], card[:elements]
      assert_equal 'trumps', card[:suit]
      assert_equal false, card[:court]
      assert_equal ['scorpio'], card[:astrological_signs]
    end
  end

  describe 'map_correspondence' do
    let(:file) { :rank }
    let(:result) { reader.map_correspondence(file) }

    it 'maps the correspondence to each given (symbolized) key' do
      assert_equal 36, result.keys.size
      assert_includes result[:minor03], 'groups'
      assert_includes result[:major13], 'point of no return'
    end

    describe 'with blank values' do
      let(:file) { :golden_dawn }

      it 'maps nil values as empty arrays' do
        assert_equal 78, result.keys.size
        assert_equal 'love', result['c_03']
        assert_empty result['c_13']
        assert_includes result['15'], 'bondage'
      end
    end
  end
end
