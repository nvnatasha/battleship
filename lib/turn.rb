class Turn

  def initialize(cpu_board, player_board, player_ships, cpu_ships)
    @cpu_board = cpu_board
    @player_board = player_board
    @player_ships = player_ships
    @cpu_ships = cpu_ships
  end

  def take_turns
      loop do
        player_take_turn
        break if all_ships_sunk?(@cpu_ships, @cpu_board)

        cpu_take_turn
        break if all_ships_sunk?(@player_ships, @player_board)
      end
    end

  def player_take_turn
    loop do
        puts "Fire away! Enter the coordinates for your first shot.".colorize(:light_blue)
        coordinate = gets.chomp.upcase
    
        if @cpu_board.valid_coordinate?(coordinate)
          @cpu_board.fire_upon(coordinate)
          show_player_shot(coordinate)
          puts "Here's the computer's board after your shot.".colorize(:light_blue)
          puts @cpu_board.render.colorize(:red)
          break
        else
          puts "Invalid coordinate, please try again.".colorize(:red)
      end
    end
  end

  def cpu_take_turn
    loop do
      random_coordinate = @player_board.cells.keys.sample
      if  @player_board.valid_coordinate?(random_coordinate) && @player_board.cells[random_coordinate].fired_upon == false
        @player_board.fire_upon(random_coordinate)
        puts "The computer has taken a shot"
        @player_board.render
        show_cpu_shot(random_coordinate)
      break
      end
    end
  end

  def show_player_shot(coordinate)
    cell = @cpu_board.cells[coordinate]
    if cell.empty?
      puts "Your shot on #{coordinate} was a miss.".colorize(:red)
      puts
    elsif cell.ship.sunk?
      puts "Your shot on #{coordinate} sunk a ship!".colorize(:green)
      puts
    else
      puts "Your shot on #{coordinate} was a hit!".colorize(:green)
      puts 
    end
  end

  def show_cpu_shot(coordinate)
    cell = @player_board.cells[coordinate]
    if cell.empty?
      puts "The computer shot on #{coordinate} was a miss."
    elsif cell.ship.sunk?
      puts "The computer shot on #{coordinate} sunk a ship!"
    else
      puts "The computer shot on #{coordinate} was a hit!"
    end
  end

  def all_ships_sunk?(ships, board)
    ships.all? { |ship| ship.sunk? }
  end

  def end_game
    if all_ships_sunk?(@cpu_ships, @cpu_board)
      puts "Game over. Congratulations, you are the winner!!"
    else
      puts "The computer sank your ships. Game over."
    end
  end
end