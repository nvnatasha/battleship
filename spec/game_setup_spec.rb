require 'spec_helper'
require_relative '../lib/game_setup'

RSpec.describe GameSetup do
    before(:each) do
        @game = GameSetup.new
    end

    describe '#initialize' do
        it 'exists' do
            expect(@game).to be_a(GameSetup)
        end

        it 'starts with empty arrays of player and cpu ships' do
            expect(@game.instance_variable_get(:@player_ships)).to eq([])
            expect(@game.instance_variable_get(:@cpu_ships)).to eq([])
        end
    end

    describe '#ship setup' do
        it 'creates player and cpu ships' do
            ship_info = [{ name: "Cruiser", length: 3 }, { name: "Submarine", length: 2 }]
            expected_ships = Ship.create_ships(ship_info)

            @game.ship_setup
            expect(@game.instance_variable_get(:@player_ships)).to all(be_an_instance_of(Ship))
            expect(@game.instance_variable_get(:@cpu_ships)).to all(be_an_instance_of(Ship))
        end
    end
end