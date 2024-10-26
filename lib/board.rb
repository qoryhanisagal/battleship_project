class Board
    attr_reader :cells

    def initialize
        @cells = create_cells
    end

    def create_cells
        grid = {}
        ('A'..'D').each do |letter| #creates rows
            (1..4).each do |number| #creates columns
                coordinate = "#{letter}#{number}"
                grid[coordinate] = Cell.new(coordinate)
            end
        end
        grid
    end

    def valid_coordinate?(coordinate)
        @cells.key?(coordinate)
    end

    def valid_placement?(ship, coordinates)
        #based on length of ship
        coordinates.length == ship.length

        #based on consecutive cells



    end

end

require './lib/cell'
require 'pry'; binding.pry
