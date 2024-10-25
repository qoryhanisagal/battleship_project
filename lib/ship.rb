# lib/ship.rb

# The Ship class represents a ship in the game, with a name, length, and health.
# It tracks its health based on its length and can take hits until it is sunk.
class Ship
  attr_reader :name, :length, :health

  # Initializes the ship with a name and length. The health starts equal to the ship's length.
  def initialize(name, length)
    @name = name                # Name of the ship (e.g., "Cruiser")
    @length = length            # Length of the ship, determining its starting health
    @health = length            # Health starts equal to the length
  end

  # Reduces the ship's health by one when it is hit, unless it is already sunk.
  def hit
    @health -= 1 if @health > 0
  end

  # Checks if the ship is sunk (health is zero).
  # Returns true if the health is zero, otherwise false.
  def sunk?
    @health == 0
  end
end

