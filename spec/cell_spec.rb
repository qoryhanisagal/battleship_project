require 'rspec'
require './lib/cell'
require './lib/ship'

RSpec.configure do |config|
  config.formatter = :documentation
end

# RSpec test suite for the Cell class, which represents a single cell on the game board.
RSpec.describe Cell do
  # JB - Before each test, set up a new Cell instance and a Ship instance for testing.
  before :each do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  # QD - Test to check if Cell object is created and has expected attributes.
  describe '#initialize' do
    it 'exists' do
      # Checks that a new Cell instance is created and not nil.
      expect(@cell).to be_a(Cell)
    end

    it 'has a coordinate' do
      # Ensures the cell's coordinate is correctly stored as "B4".
      expect(@cell.coordinate).to eq("B4")
    end

    it 'is initially empty (no ship placed)' do
      # Confirms that the cell starts with no ship.
      expect(@cell.ship).to eq(nil)
    end

    it 'is not fired upon by default' do
      # Verifies that the cell is initially not fired upon.
      expect(@cell.fired_upon?).to eq(false)
    end
  end

  # JB - Test for the place_ship method, which assigns a ship to the cell.
  describe '#place_ship' do
    it 'places a ship in the cell' do
      # Places a ship in the cell and verifies the ship attribute is updated.
      @cell.place_ship(@cruiser)
      expect(@cell.ship).to eq(@cruiser)
    end
  end

  # QD - Test for the fire_upon method, which marks the cell as fired upon and reduces ship health if applicable.
  describe '#fire_upon' do
    it 'fires upon the cell' do
      # Places a ship, fires upon the cell, and checks fired_upon status.
      @cell.place_ship(@cruiser)
      @cell.fire_upon
      expect(@cell.fired_upon?).to eq(true)
    end

    it 'reduces the health of the ship in the cell if fired upon' do
      # Places a ship in the cell, fires upon it, and verifies ship's health is reduced.
      @cell.place_ship(@cruiser)
      expect(@cruiser.health).to eq(3)
      @cell.fire_upon
      expect(@cruiser.health).to eq(2)
    end
  end

  # JB - Test for the render method, which displays the cell’s state based on different conditions.
  describe '#render' do
    it 'returns "." if the cell is empty and not fired upon' do
      # Confirms render displays "." for an untouched, empty cell.
      expect(@cell.render).to eq(".")
    end

    it 'returns "M" if the cell is empty and has been fired upon' do
      # Fires on the cell and checks that render displays "M" for a miss.
      @cell.fire_upon
      expect(@cell.render).to eq("M")
    end

    it 'returns "S" if the cell contains a ship and show_ship is true' do
      # Places a ship in the cell, and with show_ship = true, render displays "S".
      @cell.place_ship(@cruiser)
      expect(@cell.render(true)).to eq("S")
    end

    it 'returns "H" if the cell contains a ship that has been hit' do
      # Places a ship, fires upon it, and checks that render displays "H" for a hit.
      @cell.place_ship(@cruiser)
      @cell.fire_upon
      expect(@cell.render).to eq("H")
    end

    it 'returns "X" if the ship in the cell is sunk' do
      # Fires on the ship until it sinks, then checks that render displays "X" for a sunk ship.
      @cell.place_ship(@cruiser)
      @cell.fire_upon
      @cruiser.hit
      @cruiser.hit
      expect(@cell.render).to eq("X")
    end
  end
end