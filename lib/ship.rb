# Ship class to represent a ship in the game of Battleship
class Ship
  attr_reader :name, :length, :health

  # Initializes the ship with a name and a length
  # Health is set to the length of the ship initially
  # JB: Initial creation of the Ship class with basic attributes
  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  # Reduces the health of the ship by one when hit
  # JB: Added hit method to reduce health when the ship is hit
  # QD: Added safeguard to prevent health from going negative
  def hit
    @health -= 1 if @health > 0
  end

  # Checks if the ship has sunk (health is zero)
  # JB: Added sunk? method to check if the ship is fully damaged
  def sunk?
    @health == 0
  end
end