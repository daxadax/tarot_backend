require "spec_helper"

class CardSpec < EntitySpec
  let(:arcana) { :major }
  let(:card)   { Entities::Card.new(arcana) }

  describe "creation" do
    describe "without arcana" do
      let(:arcana) { '' }

      it "fails" do
        exception = assert_failure { card }

        assert_match /arcana/i, exception.message
      end
    end

    describe "when arcana is not either :major or :minor" do
      let(:arcana) { :a_different_level }

      it "fails" do
        assert_failure { card }
      end
    end

    it "is successful given a correct arcana value" do
      assert_kind_of Entities::Card, card
      assert_equal arcana, card.arcana
    end
  end
end