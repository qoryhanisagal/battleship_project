# lib/cell.rb

# The Cell class represents a single cell on the game board.
# Each cell has a coordinate, may contain a ship, and can be fired upon.
class Cell
  attr_reader :coordinate, :ship

  # Initialize the cell with a coordinate. Each cell starts empty (no ship) and unfired upon.
  def initialize(coordinate)
    @coordinate = coordinate       # The coordinate of the cell (e.g., "B4")
    @ship = nil                    # The cell initially has no ship
    @fired_upon = false            # Tracks if the cell has been fired upon
  end

  # Places a ship in the cell, making it no longer empty.
  def place_ship(ship)
    @ship = ship                   # Assigns a ship to this cell
  end

  # Checks if the cell is empty (no ship placed).
  # Returns true if there is no ship, otherwise false.
  def empty?
    @ship.nil?
  end

  # Fires upon the cell. If there is a ship in the cell, it takes a hit.
  # Sets @fired_upon to true, indicating the cell has been targeted.
  def fire_upon
    @fired_upon = true             # Marks the cell as fired upon
    @ship.hit if @ship             # If there's a ship, it takes a hit
  end

  # Checks if the cell has been fired upon.
  # Returns true if it has been fired upon, otherwise false.
  def fired_upon?
    @fired_upon
  end

  # Renders the cell's current state for display on the board.
  # Takes an optional argument, show_ship, to reveal the ship location if desired.
  # - "." for an unvisited cell
  # - "M" for a miss
  # - "H" for a hit
  # - "X" for a sunk ship
  # - "S" if show_ship is true and the cell contains a ship
  def render(show_ship = false)
    if fired_upon? && @ship.nil?
      "M"                          # Miss if fired upon an empty cell
    elsif fired_upon? && @ship && @ship.sunk?
      "X"                          # Sunk if the fired-upon ship has no health left
    elsif fired_upon? && @ship
      "H"                          # Hit if fired upon and a ship is present
    elsif show_ship && @ship
      "S"                          # Show ship location if show_ship is true
    else
      "."                          # Default state for an unvisited cell
    end
  end
end