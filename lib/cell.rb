class Cell

    attr_reader :coordinate, :ship, :empty, :hit
    attr_accessor :fire_upon

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @fired_upon = false

    end

    def place_ship(ship)
        @ship = ship
    end

    def empty? #I modified this method because it was causing some of the tests to fail. I think that's because 
        #place_ship(@ship) isn't meant to return a boolean; it places a ship in a cell. 
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