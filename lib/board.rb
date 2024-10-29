# The Board class represents the game board for Battleship.
# It manages cells, validates placements, and handles rendering the board for the game.

# lib/board.rb

require_relative './cell'
require_relative './modules/placement_validator'
require_relative './modules/renderer'

class Board
  include PlacementValidator  # Includes placement validation logic
  include Renderer            # Includes rendering capabilities for the board

  attr_reader :cells, :width, :height

  # Initializes the Board with specified width and height (default 4x4)
  # QD - Dynamically creates a grid of cells based on the width and height provided.
  # JB - Uses create_cells to populate @cells hash with coordinates as keys and Cell objects as values.
  def initialize(width = 4, height = 4)
    @width = width
    @height = height
    @cells = {}
    create_cells
  end

  # Dynamically generates cells for the board according to its dimensions.
  # QD - Populates @cells hash using letters for rows and numbers for columns.
  # JB - Ensures every cell has a unique coordinate based on board size.
  def create_cells
    ("A"...("A".ord + @height).chr).each do |letter|
      (1..@width).each do |number|
        coord = "#{letter}#{number}"
        @cells[coord] = Cell.new(coord)
      end
    end
  end

  # Delegates to PlacementValidator module for placement validation.
  # QD - Uses the PlacementValidator's logic to check if a ship placement is valid.
  # JB - Checks if ship placement adheres to board rules without embedding all validation directly.
  def valid_placement?(ship, coordinates)
    valid_placement?(ship, coordinates, @cells)
  end

  # Checks if a coordinate exists on the board.
  # QD - Ensures only valid coordinates are accessed, avoiding invalid placements.
  # JB - Useful for restricting actions to only within board boundaries.
  def valid_coordinate?(coord)
    @cells.key?(coord)
  end

  # Places a ship at the specified coordinates on the board.
  # QD - Each cell in coordinates array is assigned the ship.
  # JB - Only places the ship if the coordinates are validated beforehand.
  def place(ship, coordinates)
    coordinates.each do |coord|
      if @cells[coord]
        @cells[coord].place_ship(ship)
      else
        puts "Invalid coordinate detected: #{coord}"  # Debug line
      end
    end
  end

  # Generates random valid coordinates for placing a ship on the board.
  # QD - Generates coordinates dynamically based on ship length and board size.
  # JB - Randomizes placement for computer's ships, ensuring variability.
  def random_coordinates_for(ship)
    coordinates = []
    loop do
      start_row = ("A"...("A".ord + @height).chr).to_a.sample
      start_column = (1..@width).to_a.sample

      if rand(2).zero? # Horizontal placement
        coordinates = (start_column...(start_column + ship.length)).map { |col| "#{start_row}#{col}" }
      else # Vertical placement
        coordinates = (start_row.ord...(start_row.ord + ship.length)).map { |row| "#{row.chr}#{start_column}" }
      end

      if coordinates.all? { |coord| valid_coordinate?(coord) }
        break if valid_placement?(ship, coordinates)
      end
    end
    coordinates
  end

  # Selects a random unfired-upon coordinate from the cells.
  # QD - Provides a random coordinate for the computer's turn.
  # JB - Avoids repeated selections by excluding fired-upon cells.
  def random_unfired_coordinate
    unfired_cells = @cells.values.reject(&:fired_upon?)
    unfired_cells.sample.coordinate
  end
end