# The Board class manages the game board, including creating cells, placing ships, and validating placements.
class Board
  # Provides read-only access to @cells, which stores all cell objects on the board.
  attr_reader :cells

  # Initializes a new Board with a grid of cells.
  # The @cells hash contains each coordinate as a key and a Cell object as a value.
  def initialize
    @cells = create_cells
  end

  # Creates a 4x4 grid of cells with coordinates (e.g., "A1", "B2").
  # Returns a hash where:
  # - Each key is a coordinate string (e.g., "A1").
  # - Each value is a new Cell object located at that coordinate.
  def create_cells
    coordinates = ("A".."D").flat_map { |row| (1..4).map { |col| "#{row}#{col}" } }
    coordinates.map { |coord| [coord, Cell.new(coord)] }.to_h
  end

  # Checks if a given coordinate exists on the board.
  # Returns true if the coordinate is a key in @cells, false otherwise.
  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  # Validates ship placement according to several rules:
  # 1. All coordinates must be valid board coordinates.
  # 2. Number of coordinates must match the ship's length.
  # 3. Coordinates must be consecutive (either all in one row or one column).
  # 4. There must be no overlap with other ships.
  # Returns true if all conditions are met, false otherwise.
  def valid_placement?(ship, coordinates)
    return false unless coordinates.all? { |coord| valid_coordinate?(coord) }
    return false unless coordinates.length == ship.length
    return false unless consecutive_coordinates?(coordinates)
    return false unless no_overlap?(coordinates)

    true
  end

  # Places a ship at the specified coordinates if the placement is valid.
  # Calls place_ship on each Cell object at the given coordinates.
  def place(ship, coordinates)
    return unless valid_placement?(ship, coordinates)
    coordinates.each { |coord| @cells[coord].place_ship(ship) }
  end

  # Renders the board, displaying cell states based on the show_ships flag.
  # - If show_ships is true, it reveals cells containing ships as "S".
  # - By default (false), only shows hits, misses, and empty cells.
  def render(show_ships = false)
    "  1 2 3 4 \n" +               # Column headers
      ("A".."D").map do |row|      # Iterate over each row ("A" to "D")
        row + " " +                # Add row label (e.g., "A ")
        (1..4).map do |col|        # Iterate over each column (1 to 4)
          coord = "#{row}#{col}"   # Construct the coordinate (e.g., "A1")
          @cells[coord].render(show_ships)  # Call render on each cell with show_ships flag
        end.join(" ")              # Join cell states in the row with spaces
      end.join("\n")               # Join rows with line breaks for full board view
  end

  private  # The following methods are only used within this class for validation.

  # Checks that coordinates form a straight, consecutive line (horizontal or vertical).
  # - Consecutive horizontally if all in one row, with columns in order.
  # - Consecutive vertically if all in one column, with rows in order.
  def consecutive_coordinates?(coordinates)
    rows = coordinates.map { |coord| coord[0] }.uniq        # Get unique row letters
    cols = coordinates.map { |coord| coord[1..-1].to_i }.uniq  # Get unique column numbers as integers

    # Checks horizontal consecutiveness or vertical consecutiveness.
    (rows.size == 1 && cols.each_cons(2).all? { |a, b| b == a + 1 }) ||   # Horizontal check
      (cols.size == 1 && rows.each_cons(2).all? { |a, b| b.ord == a.ord + 1 })  # Vertical check
  end

  # Ensures no overlapping ships in the specified coordinates.
  # Returns true if none of the cells at these coordinates already contain a ship.
  def no_overlap?(coordinates)
    coordinates.none? { |coord| @cells[coord].ship }
  end
end