require 'tarot/version'
require_relative 'tarot/association_factory'
require_relative 'tarot/support/validation_helpers'
require_relative 'tarot/entities'
require_relative 'tarot/services'
require_relative 'tarot/use_cases'

module Tarot
  SuitAttributes = Struct.new(:element, :domain)

  def self.association_factory
    @association_factory ||= Tarot::AssociationFactory.new
  end

  SUITS = {
    :wands => SuitAttributes.new(:fire,  association_factory.elemental(:fire)),
    :pentacles => SuitAttributes.new(:earth, association_factory.elemental(:earth)),
    :cups => SuitAttributes.new(:water, association_factory.elemental(:water)),
    :swords => SuitAttributes.new(:air,   association_factory.elemental(:air))
  }


end
