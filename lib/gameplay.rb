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
        if user_input == "p"
            puts "Let's play!".colorize(:light_blue)
            game_setup
        end
end

def game_setup
    @turn = Turn.new

    @turn.cpu_place_ships
    @turn.player_place_ships
    @turn.cpu_board.render
end

start