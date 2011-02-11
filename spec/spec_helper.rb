$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'mocha'
require 'active_support/core_ext/module'

RSpec.configure do |config|
  config.mock_with :mocha
end

require 'streamer'
