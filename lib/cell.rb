
class Cell

    attr_reader :coordinate, :ship, :empty, :hit
    attr_accessor :place_ship, :fire_upon

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @empty = true
        @fired_upon = false

    end

    def place_ship(ship)
        @ship = ship
    end

    def empty?
        if place_ship(@ship)
            false
        else
            true
        end
    end   

    def fired_upon?
        @fired_upon
    end
    
    def fire_upon
        @fired_upon = true
        @ship.hit unless empty?
    end

    def render(show_ship = false)
        return "X" if @fired_upon && @ship&.sunk?
        return "H" if @fired_upon && !empty?
        return "M" if @fired_upon && empty?
        return "S" if show_ship && !empty?
        "."
     
    
    end
    end