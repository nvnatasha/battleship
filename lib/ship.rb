class Ship

    attr_reader :name,
                :length,
                :health

    attr_writer :health

    def initialize(name, length)
        @name = name
        @length = length
        @health = length 
    end

    def self.create_ships(ship_info)
        ship_info.map do |info|
            Ship.new(info[:name], info[:length])
        end
    end

    def hit
        @health -= 1 if @health > 0 
    end

    def sunk?
        @health == 0
    end
end
