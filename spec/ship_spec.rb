require './lib/ship'

RSpec.describe Ship do
    before(:each) do
        @cruiser = Ship.new("Cruiser", 3)
    end

    describe '#initialze' do
        it "exists" do
            expect(@cruiser).to be_instance_of(Ship)
        end

        it 'has a name' do
            expect(@cruiser.name).to eq("Cruiser")
        end

        it ' has a length' do
            expect(@cruiser.length).to eq(3)
        end
    end

    describe '#health' do
        its 'starting health is equal to its length' do

            expect(@cruiser.health).to eq(3) 
        end

        its 'health decreases by 1 when it is hit' do
            @cruiser.hit

            expect(@cruiser.health).to eq(2)
        end

        its 'health decreases by 2 when it is hit twice' do
            @cruiser.hit
            @cruiser.hit
            
            expect(@cruiser.health).to eq(1)
        end
    end

    describe '#sinking' do 
        it 'is not sunk when it is instantiated' do

            expect(@cruiser.sunk?).to eq(false)
        end

        it ' is not sunk if the number of times it has been hit is less than its length' do
            @cruiser.hit
            @cruiser.hit

            expect(@cruiser.sunk?).to eq(false)
        end

        it 'is sunk if the number of times it has been hit is equal to its length' do
            @cruiser.hit
            @cruiser.hit
            @cruiser.hit

            expect(@cruiser.sunk?).to eq(true)
        end

        it 'cannot be hit again after it has sunk' do #we probably don't have to include this, but could be an edge case if we have time
            @cruiser.hit
            @cruiser.hit
            @cruiser.hit

            expect(@cruiser.hit).to eq("Those are invalid coordinates. Please try again:")
        end
    end
end