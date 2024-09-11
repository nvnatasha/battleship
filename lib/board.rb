class Board
    attr_reader :cells

    def initialize
        @cells = {}
        create_cells
    end

    def create_cells
        ("A".."D").each do |letter|
            (1..4).each do |number|
                coordinate = "#{letter}#{number}"
                cells[coordinate] = Cell.new(coordinate)
            end
        end
    end

    def fire_upon(coordinate)
        cell = @cells[coordinate]
        cell.fire_upon if cell
    end

    def valid_coordinate?(coordinate)
        @cells.key?(coordinate)
    end

    def valid_placement?(ship, coordinates)
        return false unless coordinates.length == ship.length
        return false unless coordinates.all? { |coord| valid_coordinate?(coord) }
        return false unless coordinates.all? { |coord| @cells[coord].empty? }
            
        consecutive?(coordinates)
    end

    def place(ship, coordinates, player_ship = true) #added player_ship attribute so "Placing ship..." is only put'sed when placing a player
        if valid_placement?(ship, coordinates)
            coordinates.each do |coord|
                if player_ship 
                    puts "Placing #{ship.name} at #{coord}" 
                end
                @cells[coord].place_ship(ship)
            end
        else
            puts "Invalid placement for #{ship.name} at #{coordinates.join(", ")}"
        end
    end

    def consecutive?(coordinates)
        rows = coordinates.map { |coord| coord[0] }
        columns = coordinates.map { |coord| coord[1].to_i }

        if same_row?(rows)
            consecutive_numbers?(columns)
        elsif same_column?(columns)
            consecutive_numbers?(rows.map { |row| row.ord - 'A'.ord })
        else
            false
        end
    end

    def same_row?(rows)
        rows.uniq.length == 1
    end

    def same_column?(columns)
        columns.uniq.length == 1
    end

    def consecutive_numbers?(numbers)
        numbers.each_cons(2).all? { |a, b| b == a+1 } #simplifying this code using ruby's built in each_cons method
    end

    def render(reveal_ship = false)
        string = "  1  2  3  4  \n"
        rows = ["A", "B", "C", "D"]
        
        rows.each do |row|
            string += row + " " 
            (1..4).each do |column|
                coordinate = "#{row}#{column}"
                string += @cells[coordinate].render(reveal_ship) + "  "
            end
            string += "\n"
        end
        string
    end
end