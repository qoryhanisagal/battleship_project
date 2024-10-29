# lib/computer_player.rb

# The ComputerPlayer class manages the computer's turn logic in Battleship.
# It uses the GuessingStrategy module to make intelligent guesses based on prior hits.

require_relative './modules/guessing_strategy'  # Module for intelligent guesses

class ComputerPlayer
  include GuessingStrategy  # Provides methods for calculated moves

  attr_reader :board, :target_queue

  # Initializes the computer player with a board and an empty target queue.
  # QD - Sets up board and tracking for potential future targets.
  # JB - Initializes an empty queue for calculated moves, used after a hit.
  def initialize(board)
    @board = board
    @target_queue = []  # Queue for storing target coordinates after hits
    initialize_guessing(@board) # Initializes attributes from GuessingStrategy (@hit_tracking)
  end
  
  # Main move method; decides the next coordinate to fire upon.
  # QD - Uses calculated moves when hits exist, otherwise a random move.
  # JB - Adds hit targets to the queue to prioritize calculated shots.
  def make_move
    # Step 1: Calculate the next move based on guessing strategy
    coordinate = calculate_next_move  # Calls GuessingStrategy for next move
    
    # Step 2: Fire upon the calculated coordinate if it exists
    if coordinate
      @board.cells[coordinate].fire_upon  # Fires on the selected cell
      
      # Step 3: Update strategy if a ship was hit (adding adjacent cells to queue)
      # If a ship is present at the coordinate and it was hit, update the strategy.
      hit = @board.cells[coordinate].ship
      update_strategy(coordinate, hit) if hit
    end
    
    # Step 4: Return the chosen coordinate for reference (e.g., logging or testing)
    coordinate
  end
end