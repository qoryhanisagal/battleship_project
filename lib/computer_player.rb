# lib/computer_player.rb

# The ComputerPlayer class manages the computer's turn logic in Battleship.
# It uses the GuessingStrategy and DifficultyHandler modules for intelligent guessing and difficulty levels.

require_relative './modules/guessing_strategy'  # Module for intelligent guesses
require_relative './modules/difficulty_handler' # Module for difficulty levels

class ComputerPlayer
  include GuessingStrategy  # Provides methods for calculated moves
  include DifficultyHandler # Provides methods for difficulty level handling

  attr_reader :board, :target_queue
  attr_accessor :difficulty  # Allows GameLogic to set difficulty level

  # Initializes the computer player with a board and an empty target queue.
  # JB - Prepares board and sets difficulty, ensuring flexibility in game difficulty.
  # QD - Initializes necessary attributes for hit tracking and guessing strategy.
  def initialize(board)
    # Step 1: Assign the provided board to @board for move actions.
    @board = board
    # Step 2: Set the default difficulty level to "War Zone Waters" for initial play.
    @difficulty = :war_zone_waters
    # Step 3: Initialize an empty target queue to store adjacent cells after hits.
    @target_queue = []
    # Step 4: Initialize guessing strategy attributes (e.g., @hit_tracking).
    initialize_guessing(@board)
  end

  # Main move method that uses DifficultyHandler for move selection based on difficulty.
  # QD - Selects the appropriate move strategy from DifficultyHandler based on difficulty level.
  # JB - Calls difficulty_move from DifficultyHandler, which adapts to current difficulty setting.
  def make_move
    # Calls the move method provided by DifficultyHandler based on the set difficulty.
    difficulty_move
  end

  private # Marks the following methods as private within the class
  
  # Primary calculated move method, integrated with guessing strategy and update tracking.
  # QD - Uses calculated moves when hits exist, otherwise makes a random move.
  # JB - Adds hit targets to the queue to prioritize calculated shots.
  def make_move_with_strategy
    # Step 1: Calculate the next move based on guessing strategy
    coordinate = calculate_next_move  # Calls GuessingStrategy for next move
    
    # Step 2: Fire upon the calculated coordinate if it exists
    if coordinate
      @board.cells[coordinate].fire_upon  # Fires on the selected cell
      # Step 3: Update strategy if a ship was hit (adding adjacent cells to queue)
      hit = @board.cells[coordinate].ship
      update_strategy(coordinate, hit) if hit
    end
    # Step 4: Return the chosen coordinate for reference (e.g., logging or testing)
    coordinate
  end
end