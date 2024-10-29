# lib/modules/guessing_strategy.rb

module GuessingStrategy
  # Initializes the strategy with necessary attributes for intelligent guessing.
  def initialize_guessing(board)
    @board = board             # Store the board instance for cell access
    @hit_tracking = []         # Tracks coordinates of recent hits to target adjacent cells.
    @target_queue = []         # Queue of coordinates to guess after a hit.
  end

  # Determines the next cell to fire upon based on hit tracking or randomness.
  def calculate_next_move
    move = @target_queue.any? ? @target_queue.shift : @board.random_unfired_coordinate
    puts "Next calculated move: #{move}"  # Debugging statement
    move
  end

  # Updates the strategy based on the result of a shot.
  def update_strategy(coordinate, hit)
    # Ensures `hit` is a Ship before adding adjacent cells
    if hit.is_a?(Ship) && !@hit_tracking.include?(coordinate)
      @hit_tracking << coordinate
      add_adjacent_cells_to_queue(coordinate)
      puts "Hit recorded at #{coordinate}, adding adjacent cells. Current queue: #{@target_queue.inspect}"
    end

    # Clears the target queue if the hit ship is sunk
    if hit.is_a?(Ship) && hit.sunk?
      @target_queue.clear
      puts "Ship #{hit.name} has sunk. Clearing target queue."
    end
  end

  # Define rows array to manage rows clearly
  ROWS = ("A".."D").to_a

  # Adds adjacent cells of a hit coordinate to the target queue.
  def add_adjacent_cells_to_queue(coordinate)
    row, col = coordinate[0], coordinate[1..-1].to_i
    row_index = ROWS.index(row)

    adjacent_cells = [
      "#{row}#{col + 1}",               # Right
      "#{row}#{col - 1}",               # Left
      "#{ROWS[row_index + 1]}#{col}",   # Down
      "#{ROWS[row_index - 1]}#{col}"    # Up
    ]

    # Filter and add only valid, unfired-upon cells to the queue
    adjacent_cells.each do |cell|
      if @board.valid_coordinate?(cell) && !@board.cells[cell].fired_upon? && !@target_queue.include?(cell)
        @target_queue << cell
        puts "Adding #{cell} to target queue."  # Debugging statement for each added cell
      end
    end
    puts "Target queue after adding adjacent cells: #{@target_queue.inspect}"  # Debugging statement
  end
end