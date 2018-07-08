require 'tarot/support/validation_helpers'
require 'tarot/use_cases/use_case'
Dir[File.join(__dir__, 'use_cases', '*.rb')].each {|f| require f }

module Tarot
  module UseCases
  end
end
