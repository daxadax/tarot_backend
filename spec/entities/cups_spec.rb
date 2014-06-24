require 'spec_helper'

class CupSpec < EntitySpec

  let(:suit)    { Entities::Cup }

  describe 'initialization' do
    let(:result)  { suit.new }

    it "creates a new object for the given suit" do
      assert_kind_of suit, result

      assert_empty result.associations
    end
  end

  describe "add_associations" do
    let(:cup)          { suit.new }
    let(:associations)  { ['fire', 'captain planet'] }

    it "can set new associations" do
      cup.add_associations(associations)

      assert_equal associations, cup.associations
    end

    describe "when associations are not given as an array" do
      let(:associations) { 'fire' }

      it "fails" do
        assert_failure { cup.add_associations(associations) }
      end
    end
  end

end