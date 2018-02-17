require "spec_helper"

class CorrespondenceSpec < EntitySpec
  let(:options) do
    {
      :marseille => %w[marseille],
      :rider_waite_smith => %w{rider waite smith}
    }
  end
  let(:correspondence) do
    Entities::Correspondence.new(options)
  end

  it 'builds a correspondence object' do
    assert_equal options[:marseille], correspondence.marseille
    assert_equal options[:rider_waite_smith], correspondence.rider_waite_smith
  end
end
