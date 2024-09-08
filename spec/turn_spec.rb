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

        it 'is instantiated with boards for the player and the computer' do
            expect(@turn.player_board).to be_a(Board)
            expect(@turn.cpu_board).to be_a(Board)
        end

        it 'is instantiated with ships for the player and the computer' do
            expect(@turn.cpu_cruiser).to be_a(Ship)
            expect(@turn.player_submarine).to be_a(Ship)
        end
    end
end