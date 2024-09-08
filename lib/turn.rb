# require 'colorize'

class Turn

    # attr_reader :player_board,
    #             :cpu_board,
    #             :cpu_cruiser,
    #             :cpu_submarine,
    #             :player_cruiser,
    #             :player_submarine

    # def initialize 
    #     @player_board = Board.new
    #     @cpu_board = Board.new
    #     @cpu_cruiser = Ship.new("Cruiser", 3)
    #     @cpu_submarine = Ship.new("Submarine", 2)
    #     @player_cruiser = Ship.new("Cruiser", 3)
    #     @player_submarine = Ship.new("Submarine", 2)
    # end

    # def cpu_place_ships

    # end
    
    # def player_place_ships
        
    # end
end


    def initialize
      @player_board = Board.new
      @cpu_board = Board.new
    end
  
    def start_game
            puts "Welcome to Battleship!"
        
      
      
      place_player_ships
  
      
      place_cpu_ships
  
            puts "All ships are placed. Game is ready to start!"
    end
  
    def place_player_ships
      
        cruiser = Ship.new("Cruiser", 3)
            puts "Place your Cruiser (3 units long)."
        player_place_ship(cruiser)
  
     
        submarine = Ship.new("Submarine", 2)
            puts "Place your Submarine (2 units long)."
        player_place_ship(submarine)
    end
  
    def player_place_ship(ship)
        loop do
            puts "Enter the coordinates for your #{ship.name} (e.g., A1 A2 A3 for 3 spaces):"
        coordinates = gets.chomp.upcase.split
  
        if coordinates.size == ship.size && @player_board.valid_placement?(ship, coordinates)
          @player_board.place(ship, coordinates)
          break
        else
            puts "Invalid placement. Please try again."
        end
      end
    end
  
    def place_cpu_ships
            puts "Computer is placing its ships..."
  
      
        cruiser = Ship.new("Cruiser", 3)
        cpu_place_ship(cruiser)
  
        submarine = Ship.new("Submarine", 2)
        cpu_place_ship(submarine)
  
            puts "Computer ships are placed!"
    end
  
    def cpu_place_ship(ship)
        loop do
        coordinates = random_coordinates(ship.size)
        if @cpu_board.valid_placement?(ship, coordinates)
           @cpu_board.place(ship, coordinates)
          break
        end
      end
    end
  
    def random_coordinates(size)
        letters = ["A", "B", "C", "D"]
        numbers = ["1", "2", "3", "4"]
  
        direction = ["horizontal", "vertical"].sample
        start_letter = letters.sample
        start_number = numbers.sample.to_i
  
        coordinates = []
      
        if direction == "horizontal"
        size.times do |i|
          coordinates << start_letter + (start_number + i).to_s
        end
        else
        size.times do |i|
          coordinates << (start_letter.ord + i).chr + start_number.to_s
        end
      end
  
      coordinates
    end

  
 