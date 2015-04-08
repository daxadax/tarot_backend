require 'spec_helper'

class CupSpec < SuitSpec
  let(:suit) { :cups }

  describe "initialization" do
    it "creates a new object with default domains for the given suit" do
      assert_creation_of_suit(suit)
    end
  end
end
