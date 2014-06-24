require 'spec_helper'

class SwordsSpec < EntitySpec

  let(:suit)    { Entities::Sword }

  describe 'initialization' do
    let(:result)  { suit.new }

    it "creates a new object for the given suit" do
      assert_kind_of suit, result

      assert_empty result.associations
    end
  end

  describe "add_associations" do
    let(:sword)          { suit.new }
    let(:associations)  { ['fire', 'captain planet'] }

    it "can set new associations" do
      sword.add_associations(associations)

      assert_equal associations, sword.associations
    end

    describe "when associations are not given as an array" do
      let(:associations) { 'fire' }

      it "fails" do
        assert_failure { sword.add_associations(associations) }
      end
    end
  end

end