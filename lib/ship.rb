# Ship class to represent a ship in the game of Battleship
class Ship
  attr_reader :name, :length, :health

  # Initializes the ship with a name and a length
  # Health is set to the length of the ship initially
  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  # Reduces the health of the ship by one when hit
  def hit
    @health -= 1 if @health > 0
  end

  # Checks if the ship has sunk (health is zero)
  def sunk?
    @health == 0
  end
end