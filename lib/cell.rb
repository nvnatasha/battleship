class Cell

    attr_reader :coordinate,
                :ship, 
                :empty

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
    end

    def empty?
        true
    end

    def place_ship(name)
        @ship = name
    end

end
