class Cell

    attr_reader :coordinate,
                :ship,
                :fired_upon

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @fired_upon = false
    end

    def empty?
        @ship.nil?
    end

    def place_ship(ship)
        @ship = ship
        # require 'pry';binding.pry
    end

    def fire_upon
        @ship.hit if @ship 
        @fired_upon = true 
    end

    def fired_upon?
        @fired_upon
    end
end
