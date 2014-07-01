require 'spec_helper'

class SuitSpec < Minitest::Spec

  let(:suit_name)             { suit.to_s.capitalize }
  let(:suit_class)            { Entities.const_get(suit_name) }
  let(:element)               { SUITS[suit].element }
  let(:default_associations)  { SUITS[suit].associations }

  def assert_creation_of_suit(suit)
    result = suit_class.new

    assert_kind_of suit_class,          result
    assert_equal suit_name,             result.name
    assert_equal element,               result.element
    assert_equal default_associations,  result.associations
  end

  def assert_new_associations_are_added(associations)
    object = suit_class.new
    object.add_associations(associations)
    expected_associations = default_associations + associations

    assert_equal expected_associations, object.associations
  end

  def refute_new_associations_are_added(associations)
    assert_failure { suit_class.new.add_associations(associations) }
  end

end