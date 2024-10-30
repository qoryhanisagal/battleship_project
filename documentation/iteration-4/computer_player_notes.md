# 1st Option

``` ruby
# lib/computer_player.rb

# The ComputerPlayer class manages the computer's turn logic in Battleship.
# It uses the GuessingStrategy module to make intelligent guesses based on prior hits.

require_relative './modules/guessing_strategy'  # Module for intelligent guesses

class ComputerPlayer
  include GuessingStrategy  # Provides methods for calculated moves

  attr_reader :board, :difficulty, :target_queue

  # Initializes the computer player with a board and an empty target queue.
  # QD - Sets up board and tracking for potential future targets.
  # JB - Initializes an empty queue for calculated moves, used after a hit.
  def initialize(board)
    @board = board
    @difficulty = :medium # Defauly difficult level
    @target_queue = []  # Queue for storing target coordinates after hits
    initialize_guessing(@board) # Initializes attributes from GuessingStrategy (@hit_tracking)
  end
  
  Main move method; decides the next coordinate to fire upon.
  QD - Uses calculated moves when hits exist, otherwise a random move.
  JB - Adds hit targets to the queue to prioritize calculated shots.
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
```

# 2nd Option
``` ruby
# lib/computer_player.rb

# The ComputerPlayer class manages the computer's turn logic in Battleship.
# It uses the GuessingStrategy module to make intelligent guesses based on prior hits.

require_relative './modules/guessing_strategy'  # Module for intelligent guesses
require_relative './modules/difficulty_handler' # Module for difficulty levels
class ComputerPlayer
  include GuessingStrategy  # Provides methods for calculated moves
  include DifficultyHandler # Provide methods for difficult level

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

  # Determines the computer's move based on the difficulty level.
  # QD - Adjusts move strategy according to the selected difficulty.
  # JB - Incorporates different strategies for Calm Seas, Rough Waters, War Zone Waters, and Deep Abyss levels.
  def make_move
    case choice
    when 1
      # Step 1: Call the method for Calm Seas difficulty moves.
      @difficulty = :calm_seas
      puts "You selected Calm Seas (Easy). Let's get started!"
    when 2
       # Step 2: Call the method for Rough Waters difficulty moves.
       @difficulty = :rough_waters
      puts "You selected Rough Waters (Normal). Let's get started!"
    when 3
      @difficulty = :war_zone_waters
      # Step 3: Call the method for War Zone Waters difficulty moves.
      puts "You selected War Zone Waters (Medium). Let's get started!"
    when 
      # Step 4: Call the method for Deep Abyss difficulty moves.
      @difficulty = :deep_abyss
      puts "You selected Deep Abyss (Hard). Let's get started!"
    else
      puts "Invalid selection. Defaulting to War Zone Waters (Medium)."
      @difficulty = :war_zone_waters
    end
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

  private

  # Easy difficulty: Only uses random moves, no strategy.
  # QD - Simplifies computer logic to create an easier game experience for the player.
  # JB - Focuses solely on random moves, making computer behavior predictable.
  def easy_move
    # Step 1: Select a purely random move from available cells.
    random_guess
  end

  # Rough Waters and War Zone Waters difficulties: Mix random moves with targeting based on hits.
  # QD - Balances random moves and targeting for a moderately challenging AI.
  # JB - Checks target queue, defaulting to random when no specific targets remain.
  def medium_move
    # Step 1: Check if there are target coordinates from previous hits.
    if @target_queue.empty?
      # Step 2: If no targets are queued, make a random guess.
      random_guess
    else
      # Step 3: If targets are queued, pick the next cell from the queue.
      @target_queue.shift
    end
  end

  # Deep Abyss difficulty: Uses advanced targeting strategy for higher accuracy.
  # QD - Makes the computer's moves more strategic, increasing difficulty.
  # JB - Prioritizes calculated moves for a more challenging game experience.
  def hard_move
    # Step 1: Attempt to make a calculated guess based on hit tracking.
    if @target_queue.empty?
      # Step 2: Fallback to a random guess if no targets are queued.
      random_guess
    else
      # Step 3: Use advanced guessing method from GuessingStrategy.
      next_guess(@board)
    end
  end

  # Fires on a random coordinate from unfired cells
  # QD - Provides a random move option to avoid repeated shots.
  # JB - Ensures each shot is unique by selecting only from unfired cells.
  def random_guess
    # Step 1: Get a list of all unfired cells from the board.
    # Step 2: Select a random cell from unfired options.
    # Step 3: Return the coordinate of the selected cell.
    @board.random_unfired_coordinate
  end
end
```

