class Cell
    attr_reader :coordinate, :ship

    def initialize(coordinate)
        @coordinate = coordinate
    end

    def empty? 
        if @ship == nil
            true
        end
    end

end