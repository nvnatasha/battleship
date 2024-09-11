require 'spec_helper'
require_relative '../lib/turn'

RSpec.describe Turn do
    before(:each) do
        @player_board = Board.new
        @cpu_board = Board.new
        @cpu_board.create_cells
        @cpu_cruiser = Ship.new("Cruiser", 3)
        @cpu_submarine = Ship.new("Submarine", 2)
        @player_cruiser = Ship.new("Cruiser", 3)
        @player_submarine = Ship.new("Submarine", 2)

        @cpu_ships = [@cpu_cruiser, @cpu_submarine]
        @player_ships = [@player_cruiser, @player_submarine]

        @cell_a1 = @cpu_board.cells["A1"]
        @cell_a2 = @cpu_board.cells["A2"]
        @cell_a3 = @cpu_board.cells["A3"]
        @cell_b2 = @cpu_board.cells["B2"]
        @cell_b3 = @cpu_board.cells["B3"]
        @cell_c3 = @cpu_board.cells["C3"]
        @cell_c4 = @cpu_board.cells["C4"]

        @cell_a1.place_ship(@cpu_cruiser) 
        @cell_a2.place_ship(@cpu_cruiser) 
        @cell_a3.place_ship(@cpu_cruiser) 
        @cpu_board.place(@cpu_cruiser, ["A1", "A2", "A3"])
        @cell_c3.place_ship(@cpu_submarine) 
        @cell_c4.place_ship(@cpu_submarine) 
        @cpu_board.place(@cpu_submarine, ["C3", "C4"])
        @cell_a1.fire_upon

        @turn = Turn.new(@player_board, @cpu_board, @player_ships, @cpu_ships)
    end

    describe '#initialze' do
        it 'exists' do
            expect(@turn).to be_instance_of(Turn)
        end
    end

    describe '#taking turns' do
        it 'indicates when a cell has been fired upon' do

            expect(@cell_a1.fired_upon?).to eq(true)
        end

        it 'subtracts 1 from a hit ships health' do

            expect(@cpu_cruiser.health).to eq(2)
        end

        it 'updates the board with the results of the shot' do
            @cpu_board.place(@cpu_cruiser, ["A1", "A2", "A3"])
            @cell_b2.fire_upon

            @cpu_board.render

            expected_render = "  1  2  3  4  \n" +
                        "A H  .  .  .  \n" +
                        "B .  M  .  .  \n" +
                        "C .  .  .  .  \n" +
                        "D .  .  .  .  \n"

            expect(@cpu_board.render).to eq(expected_render)
        end

        it 'indicates on the board that a ship has been sunk' do
            @cell_a2.fire_upon
            @cell_a3.fire_upon
            
            @cpu_board.render

            expected_render = "  1  2  3  4  \n" +
                        "A X  X  X  .  \n" +
                        "B .  .  .  .  \n" +
                        "C .  .  .  .  \n" +
                        "D .  .  .  .  \n"
            expect(@cpu_board.render).to eq(expected_render)
        end

        it 'does not reduce a ships health if a cell containing the ship has already been fired upon' do
            initial_health = @cpu_cruiser.health

            expect(@cpu_cruiser.health).to eq(initial_health)
        end

        it 'returns true if all ships are sunk' do
            @player_ships.each { |ship| ship.health = 0 }
            @cpu_ships.each { |ship| ship.health = 0 }
        
            expect(@turn.all_ships_sunk?(@player_ships)).to be(true)
            expect(@turn.all_ships_sunk?(@cpu_ships)).to be(true)
        end

        it 'returns false if all ships are not sunk' do
            @player_ships.first.instance_variable_set(:@health, 0)

            expect(@turn.all_ships_sunk?(@player_ships)).to be(false)
        end
    end
end