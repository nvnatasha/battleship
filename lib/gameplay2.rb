require_relative './ship.rb'
require_relative './cell.rb'
require_relative './board.rb'
require_relative './turn.rb'
require 'pry'
require 'colorize'

def start
    puts "Welcome to Battleship!".colorize(:light_blue)
    puts "----------------------------------------------------------".colorize(:light_blue)
    puts "Enter 'p' to play or 'q' to quit.".colorize(:green)
    user_input = gets.chomp
    return puts "Goodbye!".colorize(:red) unless user_input == "p"
    puts "Let's play!".colorize(:light_blue)
    puts " "
    game_setup
end

def game_setup
    @player_board = Board.new
    @cpu_board = Board.new
    @turn = Turn.new


    puts "Here's your empty board.".colorize(:light_blue)
    puts " "
    puts "YOUR BOARD".colorize(:green)
    puts @player_board.render.colorize(:green)
    puts "When you are ready to place your ships, press enter.".colorize(:light_blue)
    gets.chomp
    puts " "

    place_player_ships
    puts "Here is what your board looks like after you placed your ships.".colorize(:light_blue)
    puts " "
    puts "YOUR BOARD".colorize(:green)
    puts @player_board.render(true).colorize(:green)
    puts "Press enter to place computer ships.".colorize(:light_blue)
    gets.chomp
    puts " "

    place_cpu_ships
    puts "COMPUTER BOARD".colorize(:red)
    puts " "
    puts @cpu_board.render.colorize(:red)

    puts "YOUR BOARD".colorize(:green)
    puts " "
    puts @player_board.render(true).colorize(:green)
    puts "All ships are placed. Game is ready to start!".colorize(:light_blue)
end

def place_player_ships
    cruiser = Ship.new("Cruiser", 3)
    puts "Place your Cruiser (3 units long).".colorize(:light_blue)
    player_place_ship(cruiser)

    submarine = Ship.new("Submarine", 2)
    puts "Place your Submarine (2 units long).".colorize(:light_blue)
    player_place_ship(submarine)
end

def player_place_ship(ship)
    loop do
        puts "Enter the coordinates for your #{ship.name} (e.g., A1 A2 A3 for 3 spaces):".colorize(:light_blue)
        coordinates = gets.chomp.upcase.split

        if coordinates.length == ship.length && @player_board.valid_placement?(ship, coordinates)
            @player_board.place(ship, coordinates)
            break
        else
            puts "Invalid placement. Please try again.".colorize(:red)
        end
    end
end

def place_cpu_ships
    puts "Computer is placing its ships...".colorize(:light_blue)

    cruiser = Ship.new("Cruiser", 3)
    cpu_place_ship(cruiser)

    submarine = Ship.new("Submarine", 2)
    cpu_place_ship(submarine)

    puts "Computer ships are placed!".colorize(:light_blue)
    puts " "
end

def cpu_place_ship(ship)
    loop do
        coordinates = random_coordinates(ship.length)
        if @cpu_board.valid_placement?(ship, coordinates)
            @cpu_board.place(ship, coordinates)
            break
        end
    end
end

def random_coordinates(length)
    letters = ("A".."D").to_a
    numbers = ("1".."4").to_a 
    
    direction = rand(2) == 0 ? "horizontal" : "vertical" 
    start_letter = rand(letters.length)
    start_number = rand(1..4)

    if direction == "horizontal"
        return random_coordinates(length) if start_number + length -1 > 4
        (0...length).map { |i| letters[start_letter] + (start_number + i).to_s }
    else
        return random_coordinates(length) if start_letter + length > 4
        (0...length).map { |i| letters[start_letter +i] + start_number.to_s }
    end
end

start