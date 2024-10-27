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
        #coordinates.length == ship.length TRUE
        #consecutive?(coordinates) TRUE
        #NOT diagonal?(coordinates) TRUE
       coordinates.length == ship.length && consecutive?(coordinates) && not_diagonal?(coordinates)
    end

    def consecutive?(coordinates)
        rows = coordinates.map { |coordinate| coordinate[0] }
        columns = coordinates.map { |coordinate| coordinate[1..-1].to_i }

        if rows.uniq.length == 1
            # All coordinates are in the same row, check for consecutive columns
            return columns.each_cons(2).all? { |a, b| b == a + 1 }
         elsif columns.uniq.length == 1
          # All in the same column, check if rows are consecutive
            return rows.each_cons(2).all? { |a, b| b.ord == a.ord + 1 }
        end
    
        false

    end

    def not_diagonal?(coordinates)
        # Check if coordinates are diagonal
        rows = coordinates.map { |coord| coord[0] }
        columns = coordinates.map { |coord| coord[1..-1].to_i }
    
        rows.uniq.length != columns.uniq.length
    end    

end