require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/turn'
require './lib/game_setup'

require 'pry'
require 'colorize'

RSpec.configure do |config|
    config.color = true
    config.formatter = :documentation
end

require 'simplecov'
SimpleCov.start