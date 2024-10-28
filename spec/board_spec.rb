# The Board spec file tests the functionality of the Board class.
# It verifies that cells are created correctly, validates coordinates and placements,
# and checks if rendering displays the board state as expected.
# Authors: JB ( Jillian) and QD (Qory)
require 'rspec'
require './lib/board'
require './lib/cell'
require './lib/ship'

RSpec.configure do |config|
    config.formatter = :documentation
  end

# Spec for Board class
RSpec.describe Board do
  before(:each) do
    # Sets up a new instance of Board and a ship (Cruiser) for use in tests.
    # QD - Each test case will use a fresh instance of the Board and Cruiser.
    # JB - Ensures test isolation, preventing interference between tests.
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe '#initialize' do
    it 'creates a board with cells' do
      # Verifies the board has exactly 16 cells.
      # QD - Checks that the correct number of cells is created (4x4 grid).
      # JB - Ensures the board is set up properly at initialization.
      expect(@board.cells.size).to eq(16)
      
      # Confirms that specific coordinates ("A1", "D4") exist on the board.
      # QD - Ensures that the correct coordinates are present on the board.
      # JB - Validates that the board includes the specified corner cells.
      expect(@board.cells.keys).to include("A1", "D4")
      
      # Checks that each coordinate on the board points to a Cell object.
      # QD - Ensures each coordinate is associated with a valid Cell instance.
      expect(@board.cells["A1"]).to be_a(Cell)
    end
  end

  describe '#valid_coordinate?' do
    it 'validates board coordinates' do
      # Verifies that a valid coordinate ("A1") returns true.
      # JB - Confirms the method correctly identifies valid coordinates.
      expect(@board.valid_coordinate?("A1")).to be true
      
      # Verifies that an invalid coordinate ("E5") returns false.
      # QD - Ensures out-of-bound coordinates are rejected.
      expect(@board.valid_coordinate?("E5")).to be false
    end
  end

  describe '#valid_placement?' do
    it 'validates ship length matches coordinates' do
      # Confirms that placing a cruiser with 3 cells is valid with 3 coordinates.
      # JB - Tests the placement length check for correctness.
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A3"])).to be true
      
      # Verifies that attempting to place a cruiser with only 2 coordinates is invalid.
      # QD - Ensures placement fails when ship length doesn’t match coordinates.
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to be false
    end

    it 'validates coordinates are consecutive' do
      # Checks that coordinates are consecutive for horizontal placement.
      # QD - Confirms placement passes when coordinates are sequential.
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A3"])).to be true
      
      # Confirms that a non-consecutive set of coordinates (e.g., gaps) returns false.
      # JB - Ensures the board rejects non-sequential coordinate placements.
      expect(@board.valid_placement?(@cruiser, ["A1", "A3", "A4"])).to be false
    end

    it 'ensures ships do not overlap' do
      # Places a cruiser on the board at valid coordinates.
      # QD - Simulates placing a ship to set up an overlap test.
      @board.place(@cruiser, ["A1", "A2", "A3"])
      
      # Confirms that placing another ship overlapping with the first returns false.
      # JB - Verifies that overlapping placements are correctly rejected.
      expect(@board.valid_placement?(@cruiser, ["A2", "A3", "A4"])).to be false
    end
  end

  describe '#place' do
    it 'places a ship on the board if valid' do
      # Places a cruiser at specified coordinates.
      # QD - Verifies correct ship placement on designated cells.
      @board.place(@cruiser, ["A1", "A2", "A3"])
      
      # Checks that each cell at "A1", "A2", and "A3" contains the cruiser.
      # JB - Ensures that each cell holds the correct ship after placement.
      expect(@board.cells["A1"].ship).to eq(@cruiser)
      expect(@board.cells["A2"].ship).to eq(@cruiser)
      expect(@board.cells["A3"].ship).to eq(@cruiser)
    end
  end

  describe '#render' do
    it 'renders the board with different cell states' do
      # Expected render output for an empty board without showing ships.
      empty_render = "  1 2 3 4 \n" +
                     "A . . . . \n" +
                     "B . . . . \n" +
                     "C . . . . \n" +
                     "D . . . . \n"
                     
      # Verifies rendering an empty board.
      # JB - Checks that render displays correctly when no ships are visible.
      # QD - Confirms default render state for each cell.
      expect(@board.render).to eq(empty_render)

      # Places a cruiser on the board at specific coordinates.
      @board.place(@cruiser, ["A1", "A2", "A3"])

      # Expected render output without revealing ships.
      hidden_render = "  1 2 3 4 \n" +
                      "A . . . . \n" +
                      "B . . . . \n" +
                      "C . . . . \n" +
                      "D . . . . \n"
                      
      # Verifies rendering a board with hidden ships.
      # QD - Confirms render output when ships are hidden.
      expect(@board.render).to eq(hidden_render)

      # Expected render output with ships visible.
      visible_render = "  1 2 3 4 \n" +
                       "A S S S . \n" +
                       "B . . . . \n" +
                       "C . . . . \n" +
                       "D . . . . \n"
                       
      # Verifies rendering a board with ships visible.
      # JB - Ensures render shows ship locations when visibility is true.
      expect(@board.render(true)).to eq(visible_render)
    end
  end
end