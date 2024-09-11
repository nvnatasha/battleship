require 'colorize'

class GameSetup
    def initialize 
        @player_ships = []
        @cpu_ships = []
    end

    def ship_setup
        ship_info = [
            { name: "Cruiser", length: 3 }, 
            { name: "Submarine", length: 2 }
        ]

        @player_ships = Ship.create_ships(ship_info)
        @cpu_ships = Ship.create_ships(ship_info)
    end

    def start
        puts "Welcome to Battleship!".colorize(:light_blue)
        puts "----------------------------------------------------------".colorize(:light_blue)
        puts "Enter 'p' to play or 'q' to quit.".colorize(:green)
        user_input = gets.chomp
        return puts "Goodbye!".colorize(:red) unless user_input == "p"
        puts "Let's play!".colorize(:light_blue)
        puts " "
        puts "Press enter to see your empty board.".colorize(:light_blue)
        gets.chomp
        ship_setup
        game_setup
    end

    def game_setup
        @player_board = Board.new
        @cpu_board = Board.new
        @turn = Turn.new(@player_board, @cpu_board, @player_ships, @cpu_ships)

        puts "Here's your empty board.".colorize(:light_blue)
        puts 
        puts "YOUR BOARD".colorize(:green)
        puts @player_board.render.colorize(:green)
        puts
        puts "When you are ready to place your ships, press enter.".colorize(:light_blue)

        place_player_ships
    
        place_cpu_ships
        sleep(1)
    
        puts "All ships are placed. Game is ready to start! \n\nPress enter when you are ready to take your first shot.\n".colorize(:light_blue)
        gets.chomp

        @turn.take_turns
    end

    def place_player_ships
        gets.chomp
        @player_ships.each do |ship|
            puts "Place your #{ship.name} (#{ship.length} units long).".colorize(:light_blue)
            player_place_ship(ship)
            puts 
            puts "Here is what your board looks like with your #{ship.name}.".colorize(:light_blue)
            puts
            sleep(1)
            puts "YOUR BOARD".colorize(:green)
            puts @player_board.render(true).colorize(:green)
            sleep(1)
            puts
        end
        puts "Press enter to place computer ships.".colorize(:light_blue)
        gets.chomp
        puts
    end

    def player_place_ship(ship)
        loop do
            example_coordinates = (1..ship.length).map { |n| "A#{n}" }.join(" ")

            puts "Enter the coordinates for your #{ship.name} (e.g., #{example_coordinates} for #{ship.length} spaces):".colorize(:light_blue)
            coordinates = gets.chomp.upcase.split

            if coordinates.length == ship.length && @player_board.valid_placement?(ship, coordinates)
                @player_board.place(ship, coordinates, player_ship = true)       
                break
            else
                puts "Invalid placement. Please try again.".colorize(:red)
            end
        end
    end

    def place_cpu_ships
        puts "Computer is placing its ships...".colorize(:light_blue)

        @cpu_ships.each do |ship|
            cpu_place_ship(ship)
        end
        sleep(1)
        puts "Computer ships are placed!".colorize(:light_blue)
        puts
        puts "COMPUTER BOARD".colorize(:red)
        puts @cpu_board.render.colorize(:red)
    end

    def cpu_place_ship(ship)
        loop do
            coordinates = random_coordinates(ship.length)
            if @cpu_board.valid_placement?(ship, coordinates)
                @cpu_board.place(ship, coordinates, player_ship = false)
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
end