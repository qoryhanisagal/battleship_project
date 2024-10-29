# The Board spec file tests the functionality of the Board class.
# It verifies that cells are created correctly, validates coordinates and placements,
# and checks if rendering displays the board state as expected.
# Authors: JB (Jillian) and QD (Qory)

require 'rspec'
require './lib/board'
require './lib/cell'
require './lib/ship'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Board do
  before(:each) do
    # QD - Initializes a standard 4x4 board for default testing scenarios
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe '#initialize' do
    it 'creates a board with cells based on default size' do
      # QD - Verifies default board dimensions (4x4 grid)
      expect(@board.cells.size).to eq(16)
      expect(@board.cells.keys).to include("A1", "D4")
    end

    it 'creates a board with custom dimensions' do
      # JB - Tests creation of a custom-sized board (e.g., 5x5)
      custom_board = Board.new(5, 5)
      expect(custom_board.cells.size).to eq(25)
      expect(custom_board.cells.keys).to include("A1", "E5")
      expect(custom_board.cells.keys).not_to include("F1")  # Out of range
    end
  end

  describe '#create_cells' do
    it 'dynamically creates cells based on board size' do
      # JB - Ensures the number of cells matches custom dimensions
      custom_board = Board.new(6, 6)
      expect(custom_board.cells.size).to eq(36)  # 6x6 board
    end
  end

  describe '#valid_coordinate?' do
    it 'validates board coordinates for default board' do
      # QD - Checks valid and invalid coordinates within a 4x4 grid
      expect(@board.valid_coordinate?("A1")).to be true
      expect(@board.valid_coordinate?("E5")).to be false
    end

    it 'validates board coordinates for custom-sized board' do
      # JB - Verifies coordinate validation on a custom-sized board
      custom_board = Board.new(5, 5)
      expect(custom_board.valid_coordinate?("E5")).to be true
      expect(custom_board.valid_coordinate?("F1")).to be false
    end
  end

  describe '#valid_placement?' do
    it 'validates ship placement on default board' do
      # QD - Verifies standard ship placements for Cruiser on 4x4 board
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A3"])).to be true
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to be false
    end

    it 'validates ship placement on custom-sized board' do
      # JB - Ensures valid placements for a ship on a larger board (6x6)
      custom_board = Board.new(6, 6)
      expect(custom_board.valid_placement?(@cruiser, ["A1", "A2", "A3"])).to be true
      expect(custom_board.valid_placement?(@cruiser, ["A5", "B5", "C5"])).to be true
    end
  end

  describe '#render' do
    it 'renders the board in correct dimensions for default size' do
      # QD - Checks rendering for the 4x4 board without ships
      empty_render = "  1 2 3 4 \nA . . . .\nB . . . .\nC . . . .\nD . . . .\n"
      expect(@board.render).to eq(empty_render)
    end

    it 'renders a custom-sized board correctly' do
      # JB - Confirms rendering for a larger board (e.g., 5x5)
      custom_board = Board.new(5, 5)
      empty_render = "  1 2 3 4 5 \nA . . . . .\nB . . . . .\nC . . . . .\nD . . . . .\nE . . . . .\n"
      expect(custom_board.render).to eq(empty_render)
    end
  end

  describe '#place' do
    it 'places a ship on the board if valid' do
      # QD - Tests placing the Cruiser on a 4x4 board
      @board.place(@cruiser, ["A1", "A2", "A3"])
      expect(@board.cells["A1"].ship).to eq(@cruiser)
      expect(@board.cells["A2"].ship).to eq(@cruiser)
      expect(@board.cells["A3"].ship).to eq(@cruiser)
    end

    it 'prevents overlapping ships on the same board' do
      # JB - Ensures overlapping ships cannot be placed on occupied cells
      @board.place(@cruiser, ["A1", "A2", "A3"])
      expect(@board.valid_placement?(@cruiser, ["A2", "A3", "A4"])).to be false
    end
  end
end