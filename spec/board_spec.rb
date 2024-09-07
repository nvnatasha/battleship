require './lib/board'
require './lib/ship'
require './lib/cell'
require 'pry'

RSpec.describe Board do
    before(:each) do
        @board = Board.new
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
end
