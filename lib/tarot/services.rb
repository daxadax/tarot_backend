require 'tarot/services/service'
Dir[File.join(__dir__, 'services', '*.rb')].each {|f| require f }

module Tarot
  module Services
  end
end
