class Cell

    attr_reader :coordinate, :ship

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @fired_upon = false

    end

    def place_ship(ship)
        @ship = ship
    end

    def empty? 
        @ship.nil?
    end   

    def fired_upon?
        @fired_upon
    end
    
    def fire_upon
        @fired_upon = true
        @ship.hit unless empty?
    end

    def render(reveal_ship = false)
        return "X" if fired_upon? && !empty? && @ship.sunk?
        return "H" if fired_upon? && !empty?
        return "M" if fired_upon? && empty?
        return "S" if reveal_ship && !empty?
        "." 
    end
end