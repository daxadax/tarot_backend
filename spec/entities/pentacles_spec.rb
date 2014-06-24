require 'spec_helper'

class PentacleSpec < SuitSpec

  let(:suit) { :pentacles }

  describe "initialization" do
    it "creates a new object with default associations for the given suit" do
      assert_creation_of_suit(suit)
    end
  end

  describe "adding new associations" do
    let(:associations) do
      ['fire', 'captain planet']
    end

    it "succeeds if given as an array" do
      assert_new_associations_are_added(associations)
    end

    it "fails otherwise" do
      refute_new_associations_are_added(associations.first)
    end
  end

end