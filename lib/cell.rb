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
