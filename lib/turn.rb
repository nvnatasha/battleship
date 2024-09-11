class Turn

  def initialize(player_board, cpu_board, player_ships, cpu_ships)
    @player_board = player_board
    @cpu_board = cpu_board
    @player_ships = player_ships
    @cpu_ships = cpu_ships
  end

  def take_turns
    loop do
            player_take_turn
         if all_ships_sunk?(@cpu_ships)
            end_game(true)
         break
    end

            cpu_take_turn
         if all_ships_sunk?(@player_ships)
            end_game(false)
         break
      end
    end
  end

  def player_take_turn
    loop do
        puts "Fire away! Enter the coordinates for your shot.".colorize(:light_blue)
        coordinate = gets.chomp.upcase
    
        if @cpu_board.valid_coordinate?(coordinate)
          @cpu_board.fire_upon(coordinate)
          show_player_shot(coordinate)
          puts "Here's the computer's board after your shot.".colorize(:light_blue)
          sleep(2)
          puts
          puts "COMPUTER BOARD".colorize(:red)
          puts @cpu_board.render.colorize(:red)

          unless all_ships_sunk?(@cpu_ships) #added so the player isn't prompted to proceed to the computer's shot once all of the cpu ships are sunk
            sleep(2)
            puts "Press enter to proceed to the computer's shot.".colorize(:light_blue)
            gets.chomp
          end
          break
        else
          puts "Invalid coordinate, please try again.".colorize(:red)
      end
    end
  end

  def cpu_take_turn
    loop do
      random_coordinate = @player_board.cells.keys.sample
      if  @player_board.valid_coordinate?(random_coordinate) && @player_board.cells[random_coordinate].fired_upon? == false
        @player_board.fire_upon(random_coordinate)
        puts "The computer has taken a shot.".colorize(:light_blue)
        sleep(1)
        show_cpu_shot(random_coordinate)
        puts
        puts "Press enter to see your board after the computer's shot.".colorize(:light_blue)
        gets.chomp
        puts "Here is your board after the computer's shot.".colorize(:light_blue)
        puts
        puts "YOUR BOARD".colorize(:green)
        puts @player_board.render.colorize(:green)

        unless all_ships_sunk?(@player_ships) #added so the player isn't asked to take another shot once all of their ships are sunk
          sleep(2)
          puts "Press enter when you're ready to take your next shot.".colorize(:light_blue)
          gets.chomp
          puts
        puts "COMPUTER BOARD".colorize(:red)
        puts @cpu_board.render.colorize(:red)
        else
        puts
        puts "COMPUTER BOARD".colorize(:red)
        puts @cpu_board.render.colorize(:red)
        gets.chomp
        end
      break
      end
    end
  end

  def show_player_shot(coordinate)
    cell = @cpu_board.cells[coordinate]
    if cell.empty?
      puts "Your shot on #{coordinate} was a miss.".colorize(:red)
      sleep(2)
      puts
    elsif cell.ship.sunk?
      puts "Your shot on #{coordinate} sunk a ship!".colorize(:green)
      sleep(2)
      puts
    else
      puts "Your shot on #{coordinate} was a hit!".colorize(:green)
      sleep(2)
      puts 
    end
  end

  def show_cpu_shot(coordinate)
    cell = @player_board.cells[coordinate]
    if cell.empty?
      puts "The computer's shot on #{coordinate} was a miss.".colorize(:red)
      sleep(2)
    elsif cell.ship.sunk?
      puts "The computer's shot on #{coordinate} sunk a ship!".colorize(:green)
      sleep(2)
    else
      puts "The computer's shot on #{coordinate} was a hit!".colorize(:green)
      sleep(2)
    end
  end

  def all_ships_sunk?(ships)
      ships.all? { |ship| ship.sunk? }
      end
  end

  def end_game(player_wins)
    if player_wins
        puts "Game over. Congratulations, you are the winner!!".colorize(:green)
    else
        puts "The computer sank all your ships. Game over.".colorize(:red)
        
    end
  end