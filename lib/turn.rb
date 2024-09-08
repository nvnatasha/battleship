require 'colorize'

class Turn

    attr_reader :player_board,
                :cpu_board,
                :cpu_cruiser,
                :cpu_submarine,
                :player_cruiser,
                :player_submarine

    def initialize 
        @player_board = Board.new
        @cpu_board = Board.new
        @cpu_cruiser = Ship.new("Cruiser", 3)
        @cpu_submarine = Ship.new("Submarine", 2)
        @player_cruiser = Ship.new("Cruiser", 3)
        @player_submarine = Ship.new("Submarine", 2)
    end

    def cpu_place_ships

    end
    
    def player_place_ships
        
    end

end