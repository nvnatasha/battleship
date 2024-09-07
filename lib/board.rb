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
end