# Cell class represents a single cell on the game board.
class Cell
    # The attr_reader provides access to instance variables:
    # - coordinate: stores the cell's coordinate (e.g., "A1", "B4").
    # - ship: stores the ship object placed in the cell (if any).
    # - fired_upon: indicates whether the cell has been fired upon or not.
    attr_reader :coordinate, :ship, :fired_upon
  
    # QD - Initialize method sets up a new cell with a given coordinate.
    # A cell starts without a ship and hasn't been fired upon.
    def initialize(coordinate)
      @coordinate = coordinate
      @ship = nil
      @fired_upon = false
    end
  
    # JB - place_ship method assigns a ship to the cell.
    def place_ship(ship)
      @ship = ship
    end
  
    # JB - fired_upon? method returns true if the cell has been fired upon, false otherwise.
    def fired_upon?
      @fired_upon
    end
  
    # JB - fire_upon method marks the cell as fired upon.
    # If the cell contains a ship, it calls the hit method on the ship.
    def fire_upon
      @fired_upon = true
      @ship.hit if @ship
    end
  
    # QD - render method displays the current state of the cell.
    # - "." if the cell has not been fired upon and is empty.
    # - "M" if the cell has been fired upon and missed (no ship).
    # - "H" if the cell has been hit (contains a ship and fired upon).
    # - "S" if the cell contains a ship and show_ship is true.
    # - "X" if the ship in the cell is sunk.
    def render(show_ship = false)
      if @ship.nil? && fired_upon?
        "M"  # Missed shot
      elsif @ship && @ship.sunk?
        "X"  # Ship sunk
      elsif @ship && fired_upon?
        "H"  # Hit on a ship
      elsif @ship && show_ship
        "S"  # Reveal ship (for special view)
      else
        "."  # Unfired empty cell
      end
    end
  end
=======
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
