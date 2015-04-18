require 'spec_helper'

class MinorArcanaSpec < EntitySpec
  let(:arcana) { :minor }
  let(:id) { 'w_07'}
  let(:rank) { '07' }
  let(:card) { Entities::MinorArcana.new(id) }

  describe "creation" do
    describe "without" do
      describe "id" do
        let(:id) { '' }
        it('fails') { assert_failure {card} }
      end
    end

    describe "with wrong values" do
      describe "id" do
        let(:id) { '07_w' }
        it('fails') { assert_failure {card} }
      end
    end

    it "is successful with correct values" do
      assert_kind_of Entities::MinorArcana, card

      assert_equal arcana, card.arcana
      assert_kind_of Entities::Wands, card.suit
      assert_equal rank, card.rank

      associations = card.associations
      assert_includes associations.general, 'acting alone'
      assert_includes associations.golden_dawn, 'valour'
    end
  end

  describe "display_name" do
    it "returns a formatted card title" do
      assert_equal "Seven of Wands", card.display_name
    end
  end

end
