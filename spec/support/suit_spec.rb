require 'spec_helper'

class SuitSpec < Minitest::Spec

  let(:suit_name)   { suit.to_s.capitalize }
  let(:suit_class)  { Entities.const_get(suit_name) }
  let(:element)     { SUITS[suit].element }
  let(:domain)      { SUITS[suit].domain }

  def assert_creation_of_suit(suit)
    result = suit_class.new

    assert_kind_of suit_class,  result
    assert_equal suit_name,     result.name
    assert_equal element,       result.element
    assert_equal domain,        result.domain
  end

  def assert_new_domains_are_added(domains)
    object = suit_class.new
    object.add_domain(domains)
    expected_domains = domain + domains

    assert_equal expected_domains, object.domain
  end

  def refute_new_domains_are_added(domains)
    assert_failure { suit_class.new.add_domain(domains) }
  end

end