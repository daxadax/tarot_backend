require './lib/tarot/use_cases/use_case'
Dir.glob("./lib/tarot/use_cases/*.rb") { |f| require f }

module Tarot
  module UseCases
  end
end
