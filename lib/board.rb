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



  
#     def initialize
#       @cells = create_cells
#     end
  
#     def create_cells
#       cells = {}
#       all_coordinates.each do |coordinate|
#         cells[coordinate] = Cell.new(coordinate)
#       end
#       cells
#     end

  
#     def all_coordinates
#       coordinates = []
#       rows.each do |row|
#         columns.each do |column|
#           coordinates << "#{row}#{column}"
#         end
#       end
#       coordinates
#     end
  

#     def rows
#       ["A", "B", "C", "D"]
#     end
  

#     def columns
#       [1, 2, 3, 4]
#     end
#   end


def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
end

def valid_placement?(ship, coordinates)
    return false unless coordinates.length == ship.length
    return false unless coordinates.all? { |coord| valid_coordinate?(coord) }
    return false unless coordinates.all? { |coord| @cells[coord].empty? }
        
    consecutive?(coordinates)
end

def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
        coordinates.each do |coord|
        @cells[coord].place_ship(ship)
        end
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
    (0...numbers.length - 1).each do |i|
    return false if numbers[i] + 1 != numbers[i + 1]
end
    true
    end
end