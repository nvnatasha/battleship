require 'colorize'

class Turn

    def initialize 
        
    end

    def player_take_turn(coordinate)
        loop do
            puts "Pick a coordinate to shoot".colorize(:light_blue)
            coordinate = gets.chomp.upcase
        
        if cpu_board.valid_coordinate?(coordinate)
            @cpu_board.fire_upon(coordinate)
            puts "Here's the board after your shot".colorize(:light_blue)
            @cpu_board.render
            show_player_shot(coordinate)
            break
        else
            puts "Invalid coordinate, please try again.".colorize(:red)
        end
    end
end

def cpu_take_turn(coordinate)
        loop do
            random_coordinate = @player_board.cells.keys.sample
        if @player_board.valid_coordinate?(random_coordinate) && @player_board.cells[random_coordinate].fired_upon == false
            @player_board.fire_upon(random_coordinate)
            puts "The computer has taken a shot"
            @player_board.render
            show_cpu_shot(random_coordinate)
            break
        end
    end 
end

def show_player_shot(coordinate)
    if @cpu_board.cells[coordinate].empty?
      puts "Your shot on #{coordinate} was a miss."
    elsif @cpu_board.cells[coordinate].ship.sunk?
      puts "Your shot on #{coordinate} sunk a ship!"
    else
      puts "Your shot on #{coordinate} was a hit!"
    end
  end

def show_cpu_shot(coordinate)
    if @player_board.cells[coordinate].empty?
      puts "The computer shot on #{coordinate} was a miss."
    elsif @player_board.cells[coordinate].ship.sunk?
      puts "The computer shot on #{coordinate} sunk a ship!"
    else
      puts "The computer shot on #{coordinate} was a hit!"
    end
  end