require 'spec_helper'

class SwordsSpec < SuitSpec

  let(:suit) { :swords }

  describe "initialization" do
    it "creates a new object with default domains for the given suit" do
      assert_creation_of_suit(suit)
    end
  end

  describe "adding new domains" do
    let(:domains) do
      ['fire', 'captain planet']
    end

    it "succeeds if given as an array" do
      assert_new_domains_are_added(domains)
    end

    it "fails otherwise" do
      refute_new_domains_are_added(domains.first)
    end
  end

end