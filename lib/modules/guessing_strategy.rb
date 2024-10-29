# lib/modules/guessing_strategy.rb

# The GuessingStrategy module contains methods for intelligent guessing in the Battleship game.
# It helps the computer player make educated guesses based on previous hits.
# Authors: JB (Jillian) and QD (Qory)

module GuessingStrategy
  # Initializes the strategy with necessary attributes for intelligent guessing.
  # QD - Keeps track of recent hits to target adjacent cells for better accuracy.
  # JB - Helps maintain a list of cells to prioritize based on hit patterns.
  def initialize_guessing(board)
    @board = board  # Store the board instance for cell access
    @hit_tracking = []       # Stores coordinates of recent hits to target adjacent cells.
    @target_queue = []       # Queue of coordinates to guess after a hit.
  end

  # Decides the next cell to fire upon based on hit tracking.
  # QD - Uses hit data to determine strategic moves, prioritizing adjacent cells.
  # JB - Allows the computer to pursue a hit sequence rather than random firing.
  def calculate_next_move
    # If there are targets in the queue, fire on the first one.
    if @target_queue.any?
      @target_queue.shift
    else
      @board.random_unfired_coordinate # Use board's method for random unfired coordinate #Help from Mentor
    end
  end

# Updates the strategy based on the result of a shot.
# QD - If a hit, adds adjacent cells to the target queue for the next moves.
# JB - Ensures a ship is fully hit by tracking nearby cells until it's sunk.
def update_strategy(coordinate, hit)
  if hit
    @hit_tracking << coordinate
    add_adjacent_cells_to_queue(coordinate)
  else
    if ship_sunk?
      puts " Haha your Ship has sunk. Clearing target queue"  # Debug message for sinking
      @target_queue.clear  # Clears tracking if the ship is sunk
    end
  end
end

# Define row array to manage rows more clearly
ROWS = ("A".."D").to_a

# Adds adjacent cells of a hit coordinate to the target queue.
# QD - Ensures strategic firing by focusing on neighboring cells after a hit.
# JB - Prioritizes adjacent cells to efficiently locate and sink ships.
def add_adjacent_cells_to_queue(coordinate)
  row, col = coordinate[0], coordinate[1..-1].to_i
  
  # Find the index of the current row
  row_index = ROWS.index(row)
  
  # QD - Get adjacent cells
  adjacent_cells = [
    "#{row}#{col + 1}",               # Right
    "#{row}#{col - 1}",               # Left
    "#{ROWS[row_index + 1]}#{col}",   # Down
    "#{ROWS[row_index - 1]}#{col}"    # Up
  ]

  # Only add valid, unfired-upon cells
  adjacent_cells.each do |cell|
    # Checks if the cell is a valid, unfired cell before adding it to the queue
    if @board.valid_coordinate?(cell) && !@board.cells[cell].fired_upon? # Use @board.cells to access cell
      @target_queue << cell
    end
  end
end

  # Ensures the coordinate is within the board’s boundaries.
  def valid_coordinate?(coord)
    @board.valid_coordinate?(coord)
  end
end