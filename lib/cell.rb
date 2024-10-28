# The Cell class represents a single cell on the game board, where ships can be placed, 
# and which can be fired upon. It tracks its status, any ship it contains, and 
# whether it has been hit.
class Cell
  # Provides read-only access to coordinate, ship, and fired_upon attributes.
  attr_reader :coordinate, :ship, :fired_upon

  # Initializes a new Cell instance at a given coordinate.
  # JB - At the start, a cell has no ship and hasn't been fired upon.
  # QD - The fired_upon attribute will be set to true once the cell is targeted in the game.
  def initialize(coordinate)
    @coordinate = coordinate  # The coordinate of the cell, e.g., "A1".
    @ship = nil               # Initially, the cell has no ship placed in it.
    @fired_upon = false       # Indicates if the cell has been targeted; starts as false.
  end

  # Places a ship in the cell by assigning a Ship object to the cell’s @ship variable.
  # JB - This method does not modify the ship's properties, only assigns it to the cell.
  # QD - Once a ship is placed, the cell is considered occupied for the game's logic.
  def place_ship(ship)
    @ship = ship              # Assigns the provided ship object to this cell.
  end

  # Returns true if the cell has been fired upon; false otherwise.
  # QD - Allows game logic to check if a cell has already been targeted.
  # JB - Helps in rendering the cell's display based on its fired_upon status.
  def fired_upon?
    @fired_upon               # Returns the value of @fired_upon (true or false).
  end

  # Marks the cell as fired upon. If the cell contains a ship, reduces the ship’s health.
  # JB - Only modifies the ship's health if the cell contains a ship, indicating a hit.
  # QD - This method ensures that a ship in the cell takes damage when fired upon.
  def fire_upon
    @fired_upon = true        # Sets the cell’s fired_upon status to true.
    @ship.hit if @ship        # Calls the ship's hit method if a ship is present.
  end

  # Returns a string representing the cell's status:
  # - "." if the cell has not been fired upon and is empty.
  # - "M"