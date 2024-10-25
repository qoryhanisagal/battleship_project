# spec/cell_spec.rb

# Require necessary files for testing
require 'rspec'
require_relative '../lib/cell'
require_relative '../lib/ship'

# Configure RSpec (optional: displays test details in documentation format)
RSpec.configure do |config|
  config.formatter = :documentation
end

# Describe the Cell class
RSpec.describe Cell do
  
  # Test 1: Initializing a Cell
  describe '#initialize' do
    it 'exists and has a coordinate' do
      # Create a new Cell object with the coordinate "B4"
      cell = Cell.new("B4")

      # Check that the cell is an instance of Cell and has the correct coordinate
      expect(cell).to be_a(Cell)
      expect(cell.coordinate).to eq("B4")
      expect(cell.ship).to be_nil       # Ensure cell starts without a ship
      expect(cell.fired_upon?).to eq(false)  # Confirm cell has not been fired upon
    end
  end

  # Test 2: Placing a Ship in the Cell
  describe '#place_ship' do
    it 'can place a ship' do
      # Initialize a Cell and a Ship
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

      # Place the ship in the cell
      cell.place_ship(cruiser)

      # Confirm that the cell now contains the ship and is no longer empty
      expect(cell.ship).to eq(cruiser)
      expect(cell.empty?).to eq(false)
    end
  end

  # Test 3: Firing Upon the Cell
  describe '#fire_upon' do
    it 'can be fired upon and affect the ship' do
      # Initialize a Cell and a Ship
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)  # Place the ship in the cell

      # Verify initial state: cell is unfired upon
      expect(cell.fired_upon?).to eq(false)

      # Fire upon the cell and check results
      cell.fire_upon
      expect(cell.fired_upon?).to eq(true)  # Confirm cell is now fired upon
      expect(cruiser.health).to eq(2)       # Confirm ship's health has decreased
    end
  end

  # Test 4: Rendering the Cell
  describe '#render' do
    it 'renders different states' do
      # Initialize two cells and a ship
      cell_1 = Cell.new("B4")
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)

      # Place the cruiser in cell_2
      cell_2.place_ship(cruiser)

      # Test rendering for an unfired-upon, empty cell
      expect(cell_1.render).to eq(".")

      # Test rendering for an unfired-upon cell containing a ship, with show_ship option
      expect(cell_2.render(true)).to eq("S")

      # Fire upon both cells
      cell_1.fire_upon
      cell_2.fire_upon

      # Check rendering results for both cells
      expect(cell_1.render).to eq("M")      # Miss for cell_1 (empty cell)
      expect(cell_2.render).to eq("H")      # Hit for cell_2 (cell with a ship)

      # Apply additional hits to sink the ship in cell_2, then check rendering
      cruiser.hit
      cruiser.hit
      expect(cell_2.render).to eq("X")      # Ship has been sunk
    end
  end
end