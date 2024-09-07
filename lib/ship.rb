class Ship

    attr_reader :name,
                :length,
                :health,
                :hit

    attr_writer :health

    def initialize(name, length)
        @name = name
        @length = length
        @health = length 
    end

    def hit
        @health -= 1 if @health > 0 
    end

    def sunk?
        @health == 0
    end
end
