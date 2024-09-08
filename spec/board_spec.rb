require './lib/board'
require './lib/ship'
require './lib/cell'
require 'pry'

RSpec.describe Board do
    before(:each) do
        @board = Board.new
        @cruiser = Ship.new("Cruiser", 3)
        @submarine = Ship.new("Submarine", 2)
    end

    describe '#initialze' do
        it "exists" do
            expect(@board).to be_instance_of(Board)
        end

        it 'is a hash' do
            binding.pry
            expect(@board.cells).to be_a(Hash)
        end
    end

    describe '#validating coordinates' do
        it 'can make sure coordinates are the correct length for the ship' do

            expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to eq(false)
        end
   
        it 'can tell if coordinates are consecutive' do

            expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to eq(false)
            expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to eq(false)
        end

        it 'can tell if coordinates are diaganol' do

            expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to eq(false)
        end

        it 'can place a ship if all parameters are correctly met' do

            expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to eq(true)
            expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to eq(true)
        end
    end

    describe '#placing ships' do
        it 'can place a ship on the board' do
            @board.place(@cruiser, ["A1", "A2", "A3"]) 
            @cell_a1 = @board.cells["A1"]
            @cell_a2 = @board.cells["A2"]
            @cell_a3 = @board.cells["A3"]

        expect(@cell_a1.ship).to eq(@cruiser)
        expect(@cell_a2.ship).to eq(@cruiser)
        expect(@cell_a3.ship).to eq(@cruiser)
        end
    end
end

