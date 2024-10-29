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
    coordinate = calculate_next_move  # Calls GuessingStrategy for next move
    @board.cells[coordinate].fire_upon  # Fires on the selected cell
    
    # Debugging line to confirm the cell is marked as fired upon
    puts "Fired upon #{coordinate}: #{@board.cells[coordinate].fired_upon?}"
  
    update_strategy(coordinate, @board.cells[coordinate].ship) if @board.cells[coordinate].ship  # Adds neighbors if a ship was hit
    coordinate
  end
end