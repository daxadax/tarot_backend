require 'spec_helper'

class CardCounterSpec < ServiceSpec
  let(:card_ids) { %w[w_03 02 c_14] }
  let(:cards) { Services::CardFactory.new.get_multiple(card_ids) }
  let(:card_counter) { Services::CardCounter.new(cards) }

  describe "count" do
    let(:result) { card_counter.count }

    it 'returns a hash keyed by the card\'s position when drawn' do
      assert_equal [0, 1, 2], result.keys
    end

    it 'returns cumulative count data for each card drawn' do
      assert_equal expected_first, result[0]
      assert_equal expected_second, result[1]
      assert_equal expected_last, result[2].sort
    end
  end

  def expected_first
    {
      :fire => 1,
      :sol => 1,
      :aries => 1
    }
  end

  def expected_second
    {
      :fire => 1,
      :sol => 1,
      :aries => 1,
      :water => 1,
      :luna => 1
    }
  end

  def expected_last
    {
      :fire => 1,
      :sol => 1,
      :aries => 1,
      :water => 2,
      :luna => 1,
      :air => 1,
      :cancer => 1
    }.sort
  end
end
