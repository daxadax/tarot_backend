require "spec_helper"

class CardSpec < EntitySpec
  let(:arcana) { :major }
  let(:card) { Entities::Card.new(arcana) }
  let(:major_card) { Entities::MajorArcana.new('01') }
  let(:non_court_card) { Entities::MinorArcana.new('w_02') }
  let(:court_card) { Entities::MinorArcana.new('p_13') }

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

    it "has a chance to be reversed" do
      assert_respond_to card, :reversed?
    end
  end

  describe "major?/minor?" do
    it "determines the type of card" do
      assert_equal true,  card.major?
      assert_equal false, card.minor?
    end
  end

  describe "court?" do
    it "determines if the card is a court card" do
      assert_equal false, major_card.court?
      assert_equal false, non_court_card.court?
      assert_equal true, court_card.court?
    end
  end

  describe 'astrological_sign' do
    it 'determines the sign of the card if present' do
      assert_nil major_card.astrological_sign
      assert_nil non_court_card.astrological_sign
      assert_equal :leo, sign_for_minor_card('w_12')
      assert_equal :aries, sign_for_minor_card('w_13')
      assert_equal :sagittarius, sign_for_minor_card('w_14')
      assert_equal :taurus, sign_for_minor_card('p_12')
      assert_equal :capricorn, sign_for_minor_card('p_13')
      assert_equal :virgo, sign_for_minor_card('p_14')
      assert_equal :scorpio, sign_for_minor_card('c_12')
      assert_equal :cancer, sign_for_minor_card('c_13')
      assert_equal :pisces, sign_for_minor_card('c_14')
      assert_equal :aquarius, sign_for_minor_card('s_12')
      assert_equal :libra, sign_for_minor_card('s_13')
      assert_equal :gemini, sign_for_minor_card('s_14')
    end
  end

  def sign_for_minor_card(id)
    Entities::MinorArcana.new(id).astrological_sign
  end
end
