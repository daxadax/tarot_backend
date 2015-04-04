require 'spec_helper'

class SuitSpec < Minitest::Spec

  let(:suit_name) { suit.to_s.capitalize }
  let(:suit_class) { Entities.const_get(suit_name) }
  let(:instance) { suit_class.new }
  let(:element) { instance.element }
  let(:domain) { instance.domain }

  def assert_creation_of_suit(suit)
    assert_kind_of suit_class, instance
    assert_equal suit_name, instance.name
    assert_equal element, instance.element
    assert_equal domain, instance.domain
  end

  def assert_new_domains_are_added(domains)
    expected_domains = domain + domains
    instance.add_domain(domains)

    assert_equal expected_domains, instance.domain
  end

  def refute_new_domains_are_added(domains)
    assert_failure { instance.add_domain(domains) }
  end

end
