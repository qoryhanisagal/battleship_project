class Cell
    attr_reader :coordinate, :ship, :fired_upon

    def initialize(coordinate)
        @coordinate = coordinate
        @fired_upon = false
    end

    def empty? 
        @ship.nil?
    end

    def place_ship(ship)
        @ship = ship
    end

    def fired_upon? 
        @fired_upon
    end

    def fire_upon
        @fired_upon = true
        
        @ship.hit if @ship
        end

    end

    def render
        return '.' unless @fired_upon
    end
end