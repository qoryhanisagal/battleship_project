# require './lib/cell'
# require './lib/ship'

class Board
    attr_reader :cells

    def initialize
        @cells = create_cells
    end

    def create_cells
        grid = {}
        ('A'..'D').each do |letter| #creates rows/x-axis
            (1..4).each do |number| #creates columns/y-axis
                coordinate = "#{letter}#{number}"
                grid[coordinate] = Cell.new(coordinate)
            end
        end
        grid
    end

    def valid_coordinate?(coordinate)
        #board.cells.keys lists array of coord as strings
        @cells.key?(coordinate)
    end

    def valid_placement?(ship, coordinates)
        #based on length of ship
        #coordinates.length == ship.length
        if coordinates.length == ship.length &&
            coordinates.each_cons(ship.length) do |coordinate|
            end
            true
         else
            false
        end
        #consecutive
        #!diagonal
    end

end

# board = Board.new
# cruiser = Ship.new("Cruiser", 3)
# submarine = Ship.new("Submarine", 2)  

# require 'pry'; binding.pry