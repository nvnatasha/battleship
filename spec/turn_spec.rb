require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/turn'
require 'pry'

RSpec.describe Turn do
    before(:each) do
        @turn = Turn.new
        @player_board = Board.new
        @cpu_board = Board.new
        @cpu_cruiser = Ship.new("Cruiser", 3)
        @cpu_submarine = Ship.new("Submarine", 2)
        @player_cruiser = Ship.new("Cruiser", 3)
        @player_submarine = Ship.new("Submarine", 2)
    end

    describe '#initialze' do
        it 'exists' do
            expect(@turn).to be_instance_of(Turn)
        end
    end
end