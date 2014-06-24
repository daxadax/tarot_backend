require 'spec_helper'

class WandsSpec < EntitySpec

  let(:suit)                  { :wands }

  let(:suit_name)             { suit.to_s.capitalize }
  let(:suit_class)            { Entities.const_get(suit_name) }
  let(:default_associations)  { SUIT_ASSOCIATIONS[suit] }

  describe "initialization" do
    let(:result) { suit_class.new }

    it "creates a new object with default associations for the given suit" do
      assert_kind_of suit_class, result

      assert_equal suit_name,             result.name
      assert_equal default_associations,  result.associations
    end
  end

  describe "add_associations" do
    let(:object) { suit_class.new }
    let(:associations) do
      ['fire', 'captain planet']
    end

    it "can set new associations" do
      object.add_associations(associations)
      expected_associations = default_associations + associations

      assert_equal expected_associations, object.associations
    end

    describe "when associations are not given as an array" do
      let(:associations) { 'fire' }

      it "fails" do
        assert_failure { object.add_associations(associations) }
      end
    end
  end

end