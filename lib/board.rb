# The Board class represents the game board for Battleship.
# It manages cells, validates placements, and handles rendering the board for the game.

require './lib/cell'

# QD - Initializes the board with a 4x4 grid by default.
# JB - Responsible for creating cells and validating ship placements.
class Board
  attr_reader :cells

  # Initializes a new board with a specified cell grid (default 4x4).
  # QD - Cells are stored in a hash with coordinates as keys and Cell objects as values.
  # JB - Uses letters A-D for rows and numbers 1-4 for columns by default.
  def initialize
    @cells = {}
    create_cells
  end

  # Creates cells for the board and stores them in the @cells hash.
  # QD - Each cell is created with a unique coordinate as the key.
  # JB - Utilizes A-D rows and 1-4 columns to fill the board.
  def create_cells
    ("A".."D").each do |letter|
      (1..4).each do |number|
        coord = "#{letter}#{number}"
        @cells[coord] = Cell.new(coord)
      end
    end
  end

  # Checks if a coordinate exists on the board.
  # QD - Ensures only valid coordinates are used.
  # JB - Prevents invalid placements or hits by verifying coordinate existence.
  def valid_coordinate?(coord)
    @cells.key?(coord)
  end

  # Validates if a ship placement is allowed at the specified coordinates.
  # QD - Checks ship length, consecutive placement, and lack of overlap.
  # JB - Ensures ships are placed linearly (either row or column, not diagonally).
  def valid_placement?(ship, coordinates)
    return false unless ship.length == coordinates.length
    return false unless consecutive_coordinates?(coordinates)
    return false if overlapping_ships?(coordinates)

    true
  end

  # Checks if coordinates are consecutive and align in a row or column.
  # QD - Validates that coordinates are sequential and not diagonal.
  # JB - Ensures ships are aligned horizontally or vertically.
  def consecutive_coordinates?(coordinates)
    letters = coordinates.map { |coord| coord[0] }
    numbers = coordinates.map { |coord| coord[1].to_i }

    same_row = letters.uniq.size == 1 && consecutive?(numbers)
    same_column = numbers.uniq.size == 1 && consecutive?(letters)

    same_row || same_column
  end

# Determines if elements in an array are consecutive.
# QD - Used for both row and column checks.
# JB - Simplifies validation for consecutive sequences.
def consecutive?(elements)
  if elements.all? { |el| el.is_a?(Integer) }
    elements.each_cons(2).all? { |a, b| b == a + 1 }
  else
    elements.map { |el| el.ord }.each_cons(2).all? { |a, b| b == a + 1 }
  end
end

  # Checks if any of the given coordinates already have ships.
  # QD - Prevents overlapping ships by ensuring cells are empty.
  # JB - Returns false if no ships are present in the given cells.
  def overlapping_ships?(coordinates)
    coordinates.any? { |coord| @cells[coord]&.ship }
  end

  # Places a ship at the specified coordinates on the board.
  # QD - Each coordinate cell is assigned the ship.
  # JB - Only places the ship if coordinates are validated beforehand.
  def place(ship, coordinates)
    coordinates.each do |coord|
      if @cells[coord]
        @cells[coord].place_ship(ship)
      else
        puts "Invalid coordinate detected: #{coord}"  # Debug line
      end
    end
  end

  # Renders the board in a string format, showing cells' statuses.
  # QD - Allows optional ship visibility with the show_ships parameter.
  # JB - Default behavior hides ships unless show_ships is true.
  def render(show_ships = false)
    rendered = "  1 2 3 4 \n"

    ("A".."D").each do |letter|
      rendered += "#{letter} "
      (1..4).each do |number|
        coord = "#{letter}#{number}"
        rendered += "#{@cells[coord].render(show_ships)} "
      end
      rendered.rstrip!
      rendered += "\n"
    end
    rendered
  end

  # Generates random valid coordinates for a ship of a given length.
  # QD - Creates a valid set of coordinates, either horizontal or vertical.
  # JB - Randomizes placement for variety in computer ship positioning.
  def random_coordinates_for(ship)
    valid_rows = ("A".."D").to_a  # Valid rows from A to D
    valid_columns = (1..4).to_a   # Valid columns from 1 to 4
    coordinates = []
  
    loop do
      # Choose a random row and column within valid range
      start_row = valid_rows.sample
      start_column = valid_columns.sample
  
      # Decide randomly whether to place ship horizontally or vertically
      if rand(2).zero? # Horizontal placement
        coordinates = (start_column...(start_column + ship.length)).map { |col| "#{start_row}#{col}" }
      else # Vertical placement
        coordinates = (start_row.ord...(start_row.ord + ship.length)).map { |row| "#{row.chr}#{start_column}" }
      end
  
      # Validate coordinates to ensure all are within the 4x4 board range
      if coordinates.all? { |coord| valid_coordinate?(coord) }
        break if valid_placement?(ship, coordinates)
      end
    end
      puts " Generated coordinates for #{ship.name}: # {coordinates}"
    coordinates
  end
  
  # Helper method to generate horizontal coordinates
  def generate_horizontal_coordinates(start_coord, length)
    row = start_coord[0]
    start_column = start_coord[1].to_i
    (start_column...(start_column + length)).map { |col| "#{row}#{col}" }
  end

  # Selects a random coordinate from cells that haven't been fired upon.
def random_unfired_coordinate
  unfired_cells = @cells.values.reject(&:fired_upon?)
  unfired_cells.sample.coordinate
end
  # Helper method to generate vertical coordinates
  def generate_vertical_coordinates(start_coord, length)
    start_row = start_coord[0].ord
    column = start_coord[1]
    (start_row...(start_row + length)).map { |row| "#{row.chr}#{column}" }
  end
end