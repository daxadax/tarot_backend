require 'tarot/version'
require_relative 'tarot/association_factory'
require_relative 'tarot/support/validation_helpers'
require_relative 'tarot/entities'
require_relative 'tarot/services'
require_relative 'tarot/use_cases'

module Tarot

  def self.association_factory
    @association_factory ||= Tarot::AssociationFactory.new
  end

end
