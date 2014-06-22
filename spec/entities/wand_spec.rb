require 'spec_helper'

class WandSpec < EntitySpec

  let(:suit)      { Entities::Wand }
  let(:suit_name) { "Wands" }

  describe 'initialization' do
    let(:result)  { suit.new }

    it "creates a new object for the given suit" do
      assert_kind_of suit, result

      assert_equal suit_name, result.name
      assert_empty            result.associations
    end
  end

  describe "add_associations" do
    let(:wand)          { suit.new }
    let(:associations)  { ['fire', 'captain planet'] }

    it "can set new associations" do
      wand.add_associations(associations)

      assert_equal associations, wand.associations
    end

    describe "when associations are not given as an array" do
      let(:associations) { 'fire' }

      it "fails" do
        assert_failure { wand.add_associations(associations) }
      end
    end
  end

end