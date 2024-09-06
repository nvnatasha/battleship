require './lib/ship'
require './lib/cell'


RSpec.describe Cell do
before(:each) do
    @cell_a1 = Cell.new("A1")
    @cell_a2 = Cell.new("A2")
    @cell_a3 = Cell.new("A3")
    @cell_a4 = Cell.new("A4")

    @cell_b1 = Cell.new("B1")
    @cell_b2 = Cell.new("B2")
    @cell_b3 = Cell.new("B3")
    @cell_b4 = Cell.new("B4")

    @cell_c1 = Cell.new("C1")
    @cell_c2 = Cell.new("C2")
    @cell_c3 = Cell.new("C3")
    @cell_c4 = Cell.new("C4")

    @cell_d1 = Cell.new("D1")
    @cell_d2 = Cell.new("D2")
    @cell_d3 = Cell.new("D3")
    @cell_d4 = Cell.new("D4")
end

    it 'can initialize' do
        @cell_a1 = Cell.new("A1")

    expect(@cell_a1).to be_an_instance_of(Cell)
    end

    it 'can name a coordinate' do

    expect(@cell_a2.coordinate).to eq("A2")
    expect(@cell_b3.coordinate).to eq("B3")
    expect(@cell_c4.coordinate).to eq("C4")
    expect(@cell_d1.coordinate).to eq("D1")
    end

    it 'will return nil if no ships have been placed' do

    expect(@cell_a1.ship).to eq(nil)
    end

    it 'can tell whether or not its empty' do

    expect(@cell_a1.empty?).to eq(true)
    end

    it 'can place a ship' do
        @cruiser = Ship.new("Cruiser", 3)
        @cell_a1.place_ship(@cruiser)
        @cell_a2.place_ship(@cruiser)
        @cell_a3.place_ship(@cruiser)

    expect(@cell_a1.ship).to eq(@cruiser)
    expect(@cell_a2.ship).to eq(@cruiser)
    expect(@cell_a3.ship).to eq(@cruiser)
    end

    it 'can tell the cell is not empty after placing a ship' do
        @cruiser = Ship.new("Cruiser", 3)
        @cell_a1.place_ship(@cruiser)

    expect(@cell_a1.empty?).to eq(false)
    end

    it 'can tell if a cell has been fired at' do
        
    expect(@cell_a1.fired_upon?).to eq(false)
        @cruiser = Ship.new("Cruiser", 3)
        @cell_a1.place_ship(@cruiser)
        @cell_a1.fire_upon

    expect(@cell_a1.fired_upon?).to eq(true)
    end

    it 'can give feedback on ship health' do
        @cruiser = Ship.new("Cruiser", 3)
        @cell_a1.place_ship(@cruiser)
        @cell_a1.fire_upon

    expect(@cell_a1.ship.health).to eq(2)
    end
end