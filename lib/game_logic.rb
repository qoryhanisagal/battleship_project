# lib/game_logic.rb

# Require necessary files and modules
require_relative './board'
require_relative './computer_player'
require_relative './ship'
require_relative './placement_validator'
require_relative './renderer'
require_relative './guessing_strategy'

# GameLogic class: Manages the overall game flow, setup, and turn-taking.
# Uses modules for placement, rendering, and guessing strategy to organize game logic.
class GameLogic
  include PlacementValidator  # QD - Handles ship placement validations
  include Renderer            # JB - Manages board rendering
  include GuessingStrategy    # QD - Supports intelligent computer move choices

  # Initializes the game with player board, computer player, and predefined ships.
  # QD - Sets up essential components for a new game session.
  # JB - Initializes core attributes to handle game flow and board state.
  def initialize
    @player_board = Board.new                      # QD - Player's game board
    @computer_player = ComputerPlayer.new(@player_board)  # JB - AI-driven opponent setup
    @ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)] # QD - Default ships for each player
  end

  # Starts the game by welcoming the player, setting up boards, and starting the main loop.
  # QD - Initiates game setup and main game loop.
  # JB - Ensures game starts with appropriate player instructions.
  def start_game
    puts "Welcome to BATTLESHIP!"
    setup_boards
    game_loop
  end

  # Sets up player and computer boards by placing ships.
  # QD - Directs both player and computer to place ships.
  # JB - Essential for establishing the starting state of each board.
  def setup_boards
    place_player_ships       # QD - Guides player through ship placement
    place_computer_ships      # JB - Automates computer ship placement using AI
  end

  # Handles player ship placement, validating each input.
  # QD - Allows player to place ships manually with valid input only.
  # JB - Rechecks each placement to ensure it’s within game rules.
  def place_player_ships
    puts "Now it's time to place your ships on the board!"
    @ships.each do |ship|
      valid = false
      until valid
        puts "Enter the coordinates for the #{ship.name} (#{ship.length} spaces):"
        coords = gets.chomp.upcase.split
        # Validates and places ship if coordinates are correct
        if valid_placement?(ship, coords)
          @player_board.place(ship, coords)
          valid = true
        else
          puts "Those coordinates are invalid. Please try again."
        end
      end
    end
  end

  # Automates computer ship placement using the ComputerPlayer class.
  # QD - Delegates ship placement to the AI for automated setup.
  # JB - Ensures ship placement meets all rules before starting the game.
  def place_computer_ships
    @computer_player.place_ships(@ships)
  end

  # Alternates turns between player and computer until one side wins.
  # QD - Main loop controlling turn-taking until game ends.
  # JB - Ensures game flow remains consistent and evaluates win conditions.
  def game_loop
    until game_over?     # QD - Runs loop as long as no winner is declared
      player_turn        # QD - Initiates player’s turn each round
      computer_turn unless game_over?  # JB - AI’s turn only if game is ongoing
    end
    end_game
  end
end