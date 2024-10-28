# Defines the Ship class, representing a ship with a specific name, length, and health.
class Ship
  attr_reader :name, :length, :health

  # Initializes a new Ship instance with a given name and length.
  # JB - Health is initially set to the ship's length, meaning it takes damage over time.
  # QD - The health attribute tracks the number of hits the ship can sustain before it sinks.
  def initialize(name, length)
    @name = name             # The name of the ship, e.g., "Cruiser".
    @length = length         # The length of the ship, representing its size.
    @health = length         # Health starts equal to the length, decreasing with each hit.
  end

  # Checks if the ship has sunk.
  # QD - Returns true if health reaches zero, indicating the ship is fully damaged.
  # JB - This method does not modify any values; it just checks the health status.
  def sunk?
    @health <= 0             # If health is zero or less, the ship is considered sunk.
  end

  # Reduces the ship's health by 1, representing a hit taken.
  # QD - This method should be called whenever the ship is fired upon.
  # JB - Health cannot go below zero; ensures health reflects the current damage level accurately.
  def hit
    @health -= 1 if @health > 0  # Reduces health by 1, but only if it's above zero.
  end
end