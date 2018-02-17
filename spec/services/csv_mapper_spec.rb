require 'spec_helper'

class CsvMapperSpec < ServiceSpec
  let(:reader) { Services::CsvMapper.new }

  it 'uses the default deck when no deck is provided' do
    assert_equal Tarot::DEFAULT_DECK, reader.send(:deck)
  end

  describe 'map_cards' do
    let(:reader) { Services::CsvMapper.new(deck: deck) }
    let(:deck)   { :marseille }
    let(:result) { reader.map_cards }

    it 'returns the correct number of cards' do
      assert_equal 78, result.size
    end

    describe 'decks' do
      describe 'tarot marseille' do
        it 'maps each value to the correct attribute' do
          card = result.detect { |c| c[:id] == 't_00' }

          assert_equal 'major', card[:arcana]
          assert_equal 'LE MAT', card[:display_name]
          assert_empty card[:elements]
          assert_equal 'trumps', card[:suit]
          assert_equal false, card[:court]
          assert_empty card[:astrological_signs]
        end
      end

      describe 'rider_waite_smith' do
        let(:deck)   { :rider_waite_smith }

        it 'maps each value to the correct attribute' do
          card = result.detect { |c| c[:id] == 't_00' }

          assert_equal 'major', card[:arcana]
          assert_equal 'The Fool', card[:display_name]
          assert_equal ['air'], card[:elements]
          assert_equal 'trumps', card[:suit]
          assert_equal false, card[:court]
          assert_equal ['uranus'], card[:astrological_signs]
        end
      end
    end

    describe 'map_correspondence' do
      let(:file) { :marseille }
      let(:result) { reader.map_correspondence(file) }

      it 'maps the correspondence to each given (symbolized) key' do
        assert_equal 78, result.keys.size
        assert_includes result['p_09'], 'opportune crisis'
        assert_includes result['t_18'], 'femininity'
      end

      describe 'with blank values' do
        let(:file) { :thoth }

        it 'maps nil values as empty arrays' do
          assert_equal 78, result.keys.size
          assert_equal 'love', result['c_03']
          assert_empty result['c_13']
          assert_includes result['t_15'], 'bondage'
        end
      end
    end
  end
end
