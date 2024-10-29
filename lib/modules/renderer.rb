# lib/modules/renderer.rb

# The Renderer module provides methods to render the board's visual representation.
# It displays the current state of each cell, with options to reveal or hide ships.
module Renderer
  # QD - Sets up the board rendering method to allow flexible board sizes.
  # JB - The render_board method shows each cell's state, and includes the option to reveal ships.

  # Renders the board, showing hits, misses, and optionally ships.
  # Parameters:
  # - cells: Hash of all cells on the board.
  # - width: The number of columns (board width).
  # - height: The number of rows (board height).
  # - show_ships: Boolean to determine if ships are visible.
  # Returns a string representing the board’s visual state.
  def render_board(cells, width, height, show_ships = false)
    # JB - Initializing the header row with column numbers.
    rendered = "  "
    (1..width).each { |i| rendered += "#{i} " }
    rendered += "\n"

    # QD - Iterates over each row based on the board height.
    # Each row letter corresponds to a different row in the visual board.
    ("A"...("A".ord + height).chr).each do |letter|
      # Starting each row with the letter identifier
      rendered += "#{letter} "

      # JB - Looping through each column for the row to render the cell state.
      # Adds cell state depending on the visibility of ships.
      (1..width).each do |number|
        coord = "#{letter}#{number}"           # Constructing the cell coordinate.
        rendered += "#{cells[coord].render(show_ships)} " # Fetches cell status (hit, miss, ship, empty).
      end
      rendered.rstrip!  # Removes any trailing space from the row.
      rendered += "\n"  # Moves to the next row.
    end
    rendered  # Returns the complete board as a string.
  end
end