require 'minitest/autorun'

$LOAD_PATH.unshift('lib', 'spec')

# require all support files
Dir.glob('./spec/support/*.rb')  { |f| require f }

require 'tarot'

ENV['test'] = '1'

class Minitest::Spec
  include Support::AssertionHelpers
  include Tarot

end
