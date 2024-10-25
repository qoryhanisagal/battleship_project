class Ship
    attr_reader :name, :length, :health

    def initialize(name, length)
        @name = name
        @length = length
        @health = length
    end

    def hit 
        if @health == 0
            puts "Ship has been sunk!"
        else
            @health -= 1 
        end
    end

end
