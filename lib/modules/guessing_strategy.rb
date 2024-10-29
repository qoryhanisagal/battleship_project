# The GuessingStrategy module contains methods for intelligent guessing in the Battleship game.
# It helps the computer player make educated guesses based on previous hits.
# Authors: JB (Jillian) and QD (Qory)

module GuessingStrategy
  # Initializes the strategy with necessary attributes for intelligent guessing.
  # QD - Keeps track of recent hits to target adjacent cells for better accuracy.
  # JB - Helps maintain a list of cells to prioritize based on hit patterns.
  def initialize_guessing
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
      random_unfired_coordinate
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
      @hit_tracking.clear if ship_sunk?  # Clears tracking if the ship is sunk
    end
  end

  # Adds adjacent cells of a hit coordinate to the target queue.
  # QD - Ensures strategic firing by focusing on neighboring cells after a hit.
  # JB - Prioritizes adjacent cells to efficiently locate and sink ships.
  def add_adjacent_cells_to_queue(coordinate)
    row, col = coordinate[0], coordinate[1..-1].to_i
    adjacent_cells = [
      "#{row}#{col + 1}", # Right
      "#{row}#{col - 1}", # Left
      "#{(row.ord + 1).chr}#{col}", # Down
      "#{(row.ord - 1).chr}#{col}"  # Up
    ]

    adjacent_cells.each do |cell|
      @target_queue << cell if valid_coordinate?(cell) && !@cells[cell].fired_upon?
    end
  end
end