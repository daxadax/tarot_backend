require './lib/tarot/services/service'
Dir.glob("./lib/tarot/services/*.rb") { |f| require f }

module Tarot
  module Services
  end
end
