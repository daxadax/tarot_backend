require "spec_helper"

class CorrespondenceSpec < EntitySpec
  let(:options) do
    {
      :golden_dawn => %w[golden_dawn]
    }
  end
  let(:correspondence) do
    Entities::Correspondence.new(options)
  end

  it 'builds a correspondence object' do
    assert_equal options[:golden_dawn], correspondence.golden_dawn
  end

  describe 'failure' do
    let(:options) do
      {
        :other => %w[some other things]
      }
    end

    it 'fails if required correspondences are not provided' do
      exception = assert_raises(ArgumentError) { correspondence }

      assert_includes exception.message, "Missing required correspondence"
    end
  end

end
