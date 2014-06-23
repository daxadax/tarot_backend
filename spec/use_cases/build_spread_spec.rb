require 'spec_helper'

class BuildSpreadSpec < UseCaseSpec
  let(:used_spread) { :enneagram }
  let(:spread) do
    UseCases::BuildSpread.new(used_spread)
  end

  describe "calling" do
    let(:result) { spread.call }

    it "returns the right number of cards for the used spread" do
      assert_equal 9, result.size
    end

    describe "with an unknown spread" do
      let(:used_spread) { :something_unknown }

      it "fails" do
        assert_failure {result}
      end
    end
  end

end