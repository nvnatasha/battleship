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
            expect(@board.cells).to be_a(Hash)
        end
    end

    describe '#validating coordinates' do
        it 'can make sure coordinates are valid' do 

            expect(@board.valid_coordinate?("A1")).to eq(true)
            expect(@board.valid_coordinate?("D4")).to eq(true)
            expect(@board.valid_coordinate?("A5")).to eq(false)
            expect(@board.valid_coordinate?("E1")).to eq(false)
            expect(@board.valid_coordinate?("A22")).to eq(false)
        end

        it 'can make sure coordinates are the correct length for the ship' do

            expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to eq(true)
        end

        it 'can make sure coordinates are consecutive' do

            expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to eq(false)
            expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to eq(false)
            expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to eq(true)
        end

        it 'can make sure coordinates are not diaganol' do

            expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to eq(false)
            expect(@board.valid_placement?(@cruiser, ["B2", "C2", "D2"])).to eq(true)
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

        it 'will not place a ship if the coordinates are invalid' do
            expect(@board.place(@cruiser, ["A5", "A6", "A7"])).to eq(nil) 
            expect(@board.place(@cruiser, ["E10", "F10", "G10"])).to eq(nil)
        end
        
        it 'will not place a ship if the placement is invalid' do
            expect(@board.place(@cruiser, ["A3", "A4", "A5"])).to eq(nil) 
            expect(@board.place(@cruiser, ["A1", "B2", "C3"])).to eq(nil)
        end

        it 'will not let ships overlap' do
            @board.place(@cruiser, ["A1", "A2", "A3"]) 
            @cell_a1 = @board.cells["A1"]
            @cell_a2 = @board.cells["A2"]
            @cell_a3 = @board.cells["A3"]

            expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to eq(false)
            expect(@board.place(@submarine, ["A1", "B1"])).to eq (nil)
            expect(@cell_a1.ship). to eq(@cruiser)
        end

        it 'indicates that a cell is no longer empty after a ship is placed in it' do
            @board.place(@cruiser, ["A1", "A2", "A3"]) 
            @cell_a1 = @board.cells["A1"]
            @cell_a2 = @board.cells["A2"]
            @cell_a3 = @board.cells["A3"]
            @cell_b1 = Cell.new("B1")

            expect(@cell_a1.empty?).to eq(false)
            expect(@cell_b1.empty?).to eq(true)
        end
    end
end