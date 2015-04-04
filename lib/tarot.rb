require 'tarot/version'
require_relative 'tarot/associations'
require_relative 'tarot/support/validation_helpers'
require_relative 'tarot/entities'
require_relative 'tarot/services'
require_relative 'tarot/use_cases'

module Tarot
  SuitAttributes = Struct.new(:element, :domain)

  def self.associations
    @associations ||= Tarot::Associations.new
  end
  
  SUITS = {
    :wands => SuitAttributes.new(:fire,  associations.elemental(:fire)),
    :pentacles => SuitAttributes.new(:earth, associations.elemental(:earth)),
    :cups => SuitAttributes.new(:water, associations.elemental(:water)),
    :swords => SuitAttributes.new(:air,   associations.elemental(:air))
  }


end
