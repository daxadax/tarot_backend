require 'minitest/autorun'

$LOAD_PATH.unshift('lib', 'spec')

# require all support files
Dir.glob('./spec/support/*.rb')  { |f| require f }

require 'tarot'

ENV['test'] = '1'

class Minitest::Spec
  include Support::AssertionHelpers
  include Tarot

  def build_card(options = {})
    attributes = options[:attributes] || default_attributes
    correspondence = options[:correspondence] || default_correspondence
    Entities::Card.new(attributes, correspondence)
  end

  private

  def default_correspondence
    Entities::Correspondence.new :general => %w[general],
      :elemental => %w[elemental],
      :golden_dawn => %w[golden_dawn]
  end

  def default_attributes
    {
      :id => '07',
      :arcana => :major,
      :display_name => "The Chariot",
      :element => [:water],
      :suit => :trumps,
      :court => false,
      :astrological_signs => [:cancer]
    }
  end

end
