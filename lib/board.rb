class Board
    attr_reader :cells

    def initialize
        @cells = create_cells
    end

    def create_cells
        cell_hash = {}
        ('A'..'D').each do |letter|
            (1..4).each do |number|
                coordinate = "#{letter}#{number}"
                cell_hash[coordinate] = Cell.new(coordinate)
            end
        end
        cell_hash
    end

    def valid_coordinate?(coordinate)
        @cells.key?(coordinate)
    end

    def valid_placement?(ship, coordinates)
        coordinates.length == ship.length
    end

end